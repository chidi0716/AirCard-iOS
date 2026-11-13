# AirCard-iOS

[English](README.md) · 繁體中文

AirCard-iOS 可以在 iPhone 上自訂 Apple 錢包卡面、鎖定畫面密碼鍵盤和 PosterBoard 桌布。

這個 fork 新增繁體中文介面，並修正從「檔案」匯入的桌布刪除後又出現的問題。

## 相容性

| iOS 版本 | 配對方式 | 功能 |
| --- | --- | --- |
| 18.0–26.x | 匯入配對檔 | 錢包卡面、密碼鍵盤主題 |
| 27.0–27.0.1 | 在 iPhone 上配對，或匯入配對檔 | 錢包卡面、密碼鍵盤主題、桌布 |
| 27.2 beta 1–2 | 在 iPhone 上配對，或匯入配對檔 | 依上游測試紀錄支援 |
| 27.2 beta 3 及更新版本 | — | 不支援 |

相容性資訊沿用上游專案。本 fork 的介面和檔案管理更新未擴大 iOS 支援範圍。

## 安裝與更新

使用 LiveContainer 時，先把 IPA 存到 iPhone 的「檔案」，再打開 LiveContainer，點右上角的 **＋** 並選取 IPA。更新既有版本時，選擇取代原本的 AirCard-iOS，以沿用資料容器和設定。未簽名的 IPA 也可透過 SideStore 或 AltStore 簽名安裝。

開啟 AirCard-iOS 後，在「配對」頁左上角點地球圖示，選擇 **繁體中文**。也可以選擇簡體中文、英文或跟隨系統。

## 功能

- **Apple 錢包卡面**：掃描卡片、選取並裁切照片，或批次套用卡面。
- **密碼鍵盤主題**：預覽按鍵配置、調整照片的位置與縮放，或匯入與匯出 `.passthm`。
- **鎖定畫面桌布**：從「檔案」匯入 `.tendies`，並在桌布分頁管理已匯入的檔案。刪除時也會清理舊版留下、內容完全相同的副本。

裝置連線需要 LocalDevVPN 和配對紀錄。在「配對」分頁可以匯入 SideStore、LiveContainer 或 iLoader 等工具提供的配對檔。iOS 27 也可透過系統設定配對。

## 從原始碼建置

專案的建置方式與原版相同，請參閱 [英文 README 的建置說明](README.md#building-from-source)。

## 來源與授權

此版本源自 [Mak5er/AirCard-iOS](https://github.com/Mak5er/AirCard-iOS)，中英文切換以 [bozer666 的 fork](https://github.com/bozer666/AirCard-iOS) 為基礎。桌布匯入修正參考 [上游 PR #69](https://github.com/Mak5er/AirCard-iOS/pull/69)。

專案採用 [MIT 授權](LICENSE)。
