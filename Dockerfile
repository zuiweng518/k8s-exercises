FROM golang:1.20  as build
LABEL  auther=mashenghao
LABEL  mail=mashenghao@126.com
WORKDIR  /app/demo
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOPROXY="https://goproxy.cn"
COPY  go.mod .
COPY  go.sum .
RUN   go mod download
COPY . . 

RUN  go build  -o  main  .
FROM  scratch
WORKDIR /app/demo
COPY --from=build  main /app/code/
COPY --from=build  views/error/*.html /app/code/views/error/
ENTRYPOINT  ["/app/code/main"]

