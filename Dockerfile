# 使用node:8.10.0作为镜像基础
FROM node:8.10.0

# 安装nginx
RUN apt-get update \
    && apt-get install -y nginx

# 指定工作目录
WORKDIR /app

# 将当前目录文件下的所有文件拷贝到工作目录
COPY . /app/

# 声明运行时容器提供服务端口
EXPOSE 80

# 1.安装依赖
# 2.运行npm run build
# 3.将dist目录文件拷贝到nginx的目录下
# 4.删除工作目录的文件，尤其是node_modules以减小镜像体积

RUN npm install \
    && npm run build \
    && cp -r build/* /var/www/html \
    && rm -rf /app

# 以前台方式启动nginx
CMD ["nginx", "-g", "daemon off;"]