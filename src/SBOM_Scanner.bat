@echo off
REM 強制 CMD 視窗切換為 UTF-8 編碼
chcp 65001 > nul

REM 設定 Proxy 網址
set http_proxy=http://192.168.110.200:3128
set https_proxy=http://192.168.110.200:3128

REM 設定批次檔Log檔案名稱與路徑
set "LogFile=%~dp0LogFile\SBOM_Scanner.log"

REM 若是指令執行會直接帶參數存入變數
set "SCAN_TARGET=%~1"

cd /d "%~dp0"

REM 建立Log資料夾
if not exist "%~dp0LogFile" (
	mkdir "%~dp0LogFile"
)

REM ==========================================
REM 如果 SCAN_TARGET 變數不為空，代表使用者是在 CMD 下指令
REM ==========================================
if not "%SCAN_TARGET%"=="" (
    echo 偵測到 CMD 參數傳入，直接進行掃描...
    goto validate_path
)

REM ==========================================
REM 點擊開啟檔案，顯示提示輸入資料夾路徑
REM ==========================================
echo ===================================================
set /p SCAN_TARGET="請輸入專案目標資料夾的【完整絕對路徑】："
echo ===================================================

REM 檢查使用者是否直接按 Enter 沒輸入
if "%SCAN_TARGET%"=="" (
    echo 錯誤：您沒有輸入任何名稱！
    echo.
    goto ErrFolder
)

:validate_path
REM 關鍵處理：去除使用者輸入中自帶的雙引號（避免重複引號引發閃退）
set "SCAN_TARGET=%SCAN_TARGET:"=%"

REM 檢查目標專案絕對路徑是否存在
if not exist "%SCAN_TARGET%" (
    echo 【錯誤】找不到該目標路徑，請確認資料夾是否存在！
    echo.
    goto ErrFolder
)

echo 檢查通過，開始掃描目標路徑...
echo ===================================================
REM 初始化匯出資料夾
set "targetFolder=%~dp0\report"
if exist "%targetFolder%" (
	echo 偵測到舊資料夾...
    echo 初始化匯出資料夾...
    rd /s /q "%targetFolder%"
	echo 初始化完成！
)

REM 建立匯出資料夾
mkdir "%targetFolder%"

echo 開始匯出SBOM資料...
set "SYFT_FORMAT_PRETTY=true" && syft %SCAN_TARGET% ^
  -o spdx-json=.\report\SYFT_SBOM.spdx.json

echo Syft Sbom 掃描完成！
echo ===================================================

echo 開始比對弱點資料庫...
vulnerability_tool\trivy\trivy.exe sbom --format template --template "@vulnerability_tool\trivy\contrib\html.tpl" -o report\trivy_report.html "report\SYFT_SBOM.spdx.json" 2> "trivy_temp.tmp"

if %errorlevel% neq 0 (
    type "trivy_temp.tmp" >> "LogFile\trivy.log"
)
if exist "trivy_temp.tmp" del "trivy_temp.tmp"

echo Trivy 比對完成！
echo ===================================================

vulnerability_tool\grype\grype.exe -o template -t vulnerability_tool\grype\html.tmpl sbom:report\SYFT_SBOM.spdx.json > report\grype_report.html 2> "grype_temp.tmp"

if %errorlevel% neq 0 (
    type "grype_temp.tmp" >> "LogFile\grype.log"
)
if exist "grype_temp.tmp" del "grype_temp.tmp"

echo Grype 比對完成！
echo ===================================================

vulnerability_tool\ovs_scanner\osv-scanner_windows_amd64.exe -L "report\SYFT_SBOM.spdx.json" --format html --output-file report\osv_report.html 2> "osv_temp.tmp"

if %errorlevel% neq 0 (
    type "osv_temp.tmp" >> "LogFile\osv.log"
)
if exist "osv_temp.tmp" del "osv_temp.tmp"

echo osv 比對完成！

exit /b 0

:ErrFolder
REM  錯誤目標資料夾
ECHO Cannot find the target folder, batch file terminated time : %DATE% %TIME% >> %LogFile%
ECHO. >> %LogFile%

EXIT /b 1