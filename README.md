# Auto sbom scanner batch file
A Windows batch script to automatically generate SBOMs and scan for vulnerabilities.

以 Windows 批次檔案 ( .bat ) 自動化匯出 SBOM 文件及弱點報表。
## Features
- **3-in-1 Multi-Engine Scanning**

  Combines the power of **Trivy**, **Grype**, and **OSV-Scanner** to deliver maximum vulnerability detection coverage.
  
  結合 Trivy、Grype 和 OSV-Scanner 的強大功能，提供最大化的弱點偵測覆蓋率。

- **One-Click Automation**

  Automatically generates standardized SBOM JSON files and performs vulnerability scanning in a single run.
  
  單次執行能自動產出標準的 SBOM JSON 檔案並執行弱點掃描。

- **Directory-Targeted**

  Just input your compiled build folder to analyze all software dependencies instantly.
  
  只需輸入編譯好的建置資料夾，即可立刻分析所有軟體相依性。

- **Native Windows Batch**

  Runs efficiently via a lightweight `.bat` script, requiring zero complex environment setups like Python or Node.js.
  
  透過輕量化的 `.bat` 腳本高效執行，完全不需要安裝 Python 或 Node.js 等複雜環境。

- **CI/CD Ready**

  Easy to integrate into local development workflows or Windows-based automation pipelines.
  
  非常容易整合進本地開發工作流程或 Windows 架構的 CI/CD 自動化管線中。
