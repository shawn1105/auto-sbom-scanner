初版撰寫時間 2026/5/26
=================================================================
【SBOM 匯出程式】
- Syft -

目前版本：
syft_1.44.0_windows_amd64

下載位置：
https://github.com/anchore/syft/releases

備註：
下載最新Releases版本「syft_1.44.0_windows_amd64.zip」。
=================================================================
【弱點比對程式】
- Trivy -

目前版本：
trivy_0.70.0_windows-64bit

下載位置：
https://github.com/aquasecurity/trivy/releases

備註：
下載最新Releases版本「trivy_0.70.0_windows-64bit.zip」。
----------------------------------------------
- Grype -

目前版本：
grype_0.112.0_windows_amd64

下載位置：
https://github.com/anchore/grype/releases

備註：
下載最新Releases版本「grype_0.112.0_windows_amd64.zip」，*取代檔案時請確保html.tmpl檔案必須存在，否則匯出html會有問題。
----------------------------------------------
- OSV-scanner -

目前版本：
V2.3.8

下載位置：
https://github.com/google/osv-scanner/releases

備註：
下載最新Releases版本「osv-scanner_windows_amd64.exe」，官方應用程式比對當有弱點必定會產生osv.log。
=================================================================
【批次檔使用說明】
** 注意事項 **
1. 使用前先開啟編輯批次檔確認 Proxy 網址正確。
2. 執行方式使用指令執行必須給予目標專案路徑，若為空則會單純開啟批次檔案(雙擊執行流程)。

** 執行方式 **
1. 指令執行，系統管理員身分開啟命令提示字元，指令方式帶目標專案路徑參數執行。
2. 雙擊執行，雙擊點開輸入目標專案路徑執行。