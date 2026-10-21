# app-privacy-policy-generator (Docker image)

Static-site Docker image for [App Privacy Policy Generator](https://github.com/nisrulz/app-privacy-policy-generator)（为移动应用生成隐私政策与服务条款的在线工具）。

镜像：`ghcr.io/dockers-x/app-privacy-policy-generator:<version>` / `:latest`，nginx 1.27 托管上游 `public/` 构建产物，监听 8080。

## 说明

上游把构建好的多语言静态页（168 个文件，含 `de/`、`fr/` 等语言目录）提交进 `public/`，因此镜像只拷贝该目录，不执行 `go run ./cmd/build/`——镜像内容与上游发布 tag 完全一致。

## 构建

GitHub Actions 每日检查上游 tag（5.2.2 等），新版本自动构建 multi-arch（amd64/arm64）镜像并推送。

## 许可

AGPL-3.0（上游）
