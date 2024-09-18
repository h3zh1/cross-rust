# cross-rust
此项目主要用于维护[malefic](https://github.com/chainreactors/malefic/)的编译。

项目使用了[cross](https://github.com/cross-rs/cross)的Dockerfile和script。
考虑到编译环境足够干净的问题，重构了cross的结构，并因为一些限制放弃了`cargo build-docker-image`和`cross`等，修复了一些其他问题。

## Usage
### 准备操作
1. 安装了docker环境可参考[官网介绍](https://www.docker.com/)
2. 切换到项目路径
    ```
    # switch to the root dir of your rs project
    cd /path/to/project_/
    ```

### 单行编译
根据对应target，选择对应镜像来进行编译，此处以build`x86_64-pc-windows-msvc`简单举例。
```
docker run -v "$PWD/:/root/src" --rm -it --name cross-builder ghcr.io/chainreactors/x86_64-pc-windows-msvc:nightly-2024-08-16 cargo build --release --target x86_64-pc-windows-msvc
```

### 交互式编译
```
docker run -v "$PWD/:/root/src" --rm -it --name cross-builder ghcr.io/chainreactors/x86_64-pc-windows-msvc:nightly-2024-08-16 bash
cargo build --release --target x86_64-pc-windows-msvc
```
### 注意
1. 如果你想重复使用你的容器请不要使用--rm
2. 所有的可用架构你可以在[package](https://github.com/orgs/chainreactors/packages?repo_name=cross-rust)中找到
3. 欢迎补充新的架构，有其他问题请题issue

## 其他
如果你想FORK此项目，自行构建镜像可参考".github/workflows/build.yml"，自行配置对应的secrets。

### Github Action构建
```
gh auth login
```
所有架构
```
gh workflow run build.yml -R your_username/cross-rust -f  targets="all" -f tool_chain_version="nightly-2024-08-16"
```
选择性build
```
gh workflow run build.yml -R your_username/cross-rust -f  targets="x86_64-pc-windows-msvc,i686-pc-windows-msvc" -f tool_chain_version="nightly-2024-08-16"

```
### 本地构建
具体目录参考项目代码和github action的build.yaml
```
docker build -t image_name:tag -f Dockerfiles/*/Dockerfile.* .
```