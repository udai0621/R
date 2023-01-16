#　ベクトルを作ってみよう c()
x <- c(1,2,3,4,5)  # <-：代入
y <- c(1:5, 3:5)  # :：連続した整数を生成
z <- c(rep(3,4),rep(c(1,5,10),c(2,3,4)))  # rep：rep(a,b)でaをb個並べるの意味。rep(c(1,5,10),c(2,3,4))は、1を2個、５を3個、１０を4個の意味。
a <- c("A","B","C")
x
y
z
a

# 行列を作ってみよう　matrix(要素ベクトル、行数、列数)
mat1 <- matrix(c(1:10), nrow=2, ncol=5)
mat1 <- matrix(c(1:10), 2, 5)
mat2 <- matrix(c(1:10), 2, byrow = TRUE)  # byrow=TRUE：横に順番に並べるという指定。デフォルトはFALSEであり、縦に並べる
mat3 <- matrix(c(1,3,2,5,7,3,2,15,2), 3, 3, byrow = TRUE)
mat1
mat2
mat3

# 行列の計算をしてみよう（四則演算）
mat1 + mat2
mat1 - mat2
mat1 * mat2
mat1 / mat2
mat3 %*% mat3  # 行列同士の掛け算
solve(mat3)  # 逆行列を求める

# 行列内の要素を参照してみよう
p <- mat1[1,2]
q <- mat3[,2]
r <- mat1[1,c(2,5)]  # 1行目の2列目と5列目を取り出すの意味
p
q
r

# データの読み込み方とデータのアクセス(参照)方法　→csv形式
getwd()  # 現在の作業ディレクトリを確認
setwd("./notebook/data")  # 作業ディレクトリの変更
df<-read.csv("sample-data.csv",header = TRUE, row.names = 1, fileEncoding = "shift-jis")  # ファイル名、ヘッダーの有無、列名の有無、エンコーディングの指定を行う
df

# データのアクセス（参照）方法
df[,1]
df[1:4,]
df$年齢  # $を使うことで、その名前の列を抽出可能

# データの取り出し方（例①〜⑥）
# 例①：男性だけを取り出す。（3つとも同じデータを抽出できる）
M.dat <- subset(df,df$性別 == "M")
M.dat <- subset(df,df[,4] == "M")
M.dat <- df[df$性別 == "M", ]
M.dat

# 例②：体重が60kg未満の人を取り出す。
weight60 <- subset(df,df$体重 < 60)
weight60 <- df[df[,6] < 60,]
weight60

# 例③：男性かつ体重が６０kg未満
M.60 <- subset(df,df$性別 == "M" & df$体重 < 60)
M.60 <- df[df[,4] == "M" & df[,6] < 60, ]
M.60

# 例④：肺活量４０００以上の人
h <- subset(df, df$肺活量 >= 4000)
h

# 例⑤：肺活量が3000以上、４０００以下の人
h1 <- subset(df, df$肺活量　>= 3000 & df$肺活量 <= 4000)
h

# 例⑥：病気の列が1であり、体重が７0kg以上
b <- subset(df, df$病気 == 1 & df$体重 >= 70)
b

# 便利コマンドの紹介

# ncol,nrow 列数、行数をカウント
nrow(df)
ncol(df)

# data＄列名 参照したい列をベクトルとして取り出す
df$性別
df$血圧

# table 要素の数をカウントするコマンド(感動)
table(df$性別) 
table(df$性別, df$病気)

# colnames,rownames 列名、行名を見るコマンド
colnames(df)
rownames(df)

# numeric,rep 同じものをたくさん並べるベクトルの生成
numeric(15)  # 0限定
rep(0,15)

# as.numeric,as.character 変数の方の変換
da <- 12345
da.ch <- as.character(da) 
da.ch
da <- as.numeric(da.ch)
da

# is.numeric,is.character 変数の型の確認
is.character(da)
is.numeric(da)
is.numeric(da.ch)

# is.na,na.omit NA(欠損値)にまつわるコマンド
y <- c(NA, 1, 2, NA, 5)
is.na(y)  # NAかどうかを調べる
na.omit(y)  # NAを除く

# length ベクトルの長さを調べるコマンド
z <- c(2, 4, 6, 1, 3, 5)
length(z)
a <- c(1, 2, 3, 1, 2, 3, 1, 2, 3)
unique(a)  # 重複する要素を除く

# union,setdiff,intersect 和集合、差集合、積集合
k <- 1:10
I <- seq(2, 20, by = 2)
union(k,I)
setdiff(k, I)
intersect(k, I)

# 繰り返しのfor文
ans <- 0
for (i in 1:10){
    ans = ans + 1
}
ans

# 条件式のif文
ans <- 0
if (ans == 0){
    ans = ans + 1
}
ans

# その他
b <- c(1,4,5,3,7,8,9,9,2,5)
mean(b)
var(b)
sd(b)
median(b)
sum(b)
max(b)
min(b)
rev(b)  # reverse
order(b)  # 小さい順に並べた時の番号を伝えてくれる
sort(b) # 昇順
sort(b, decreasing = TRUE)

# Rで線形モデルによる回帰分析
# lm()関数を用いて、単回帰分析
y <- c(1,3,4,10,5,1,3,14,21)
x <- c(10,20,10,40,50,10,10,20,70)

ans <- lm(y~x)  # lm(目的変数〜説明変数)
ans

# 回帰分析のより詳細な結果を"summary()"関数で抽出
s.ans <- summary(ans)
s.ans

# 解析結果をwrite.tableでcsvファイルに出力
coe <- s.ans$coefficient  # 回帰係数を抽出
aic <- AIC(ans)  # AICを抽出
N <- length(y)  # 解析したデータの総数を抽出
result <- cbind(coe, aic, N)  # 結果をまとめる　/ cbind : 行数が同じ行列同士を横にくっつけて新しい行列を作る
result[2, 5:6] <- ""  # 指定した位置のデータを空にしてる
result

# 作業ディレクトリの確認および変更
getwd()
setwd("./..")
getwd()

# 結果を書き出す write.table(出力変数、　出力ファイル名、　出力オプション)
# 出力オプション〜　append=T:ファイルへの追加出力を許可　/ quote=F:引用符""の出力拒否 row.names=T:行名も出力　/ col.names=:列名は未出力　
# 列名の用意を実行。
write.table(matrix(c("",colnames(result)), nrow = 1), "回帰分析.csv", append = T, quote = F, sep = ",", row.names = F, col.names = F)
# 用意した箱の中に、実際のデータを書き出している。
write.table(result, "回帰分析.csv", append = T, quote = F, sep = ",", row.names = T, col.names = F)
matrix(c("",colnames(result)), nrow = 1)


# 実データを用いた重回帰分析
ans <- lm(df$肺活量 ~ df$血圧 + df$体重)

# 結果を整理してcsvに出力
s.ans <- summary(ans)
coe <- s.ans$coefficients
N <- nrow(df)
aic <- AIC(ans)
result <- cbind(coe, aic, N)
result[2:nrow(result), 5:6] <- ""
filename <- "重回帰出力test1.csv"

write.table(matrix(c("", colnames(result)), nrow = 1), filename, append = T, quote = F, sep = ",", row.names = F, col.names = F)
write.table(result, filename, append = T, quote = F, sep = ",", row.names = T, col.names = F)

# 説明変数が多くなった場合に完結に書く方法
dat <- df[,c(3,2,1)]  # 使う説明変数を指定
ans <- lm(df$肺活量~.,data=dat)

# 関数の作り方　<- function(引数){関数内で行う処理}
fun1 <- function(x){
    a <- x^2
    b <- x+10
    ans <- a+b
    return(ans)
}

fun1(10)

# 例：ロジスティック回帰分析の関数
fun2 <- function(dat, num){
    ans <- glm(df$病気~.,data = dat, family = binomial)
    s.ans <- summary(ans)
    coe <- s.ans$coefficients
    N <- nrow(df)
    aic <- AIC(ans)
    result <- cbind(coe, aic, N)
    result[2:nrow(result), 5:6] <- ""
    filename <- paste("logistic回帰-sample-", num, "変量.csv", sep = "")
    write.table(matrix(c("", colnames(result)), nrow = 1), 
                filename, 
                append = F, 
                quote = F, 
                sep = ",",
                row.names = F,
                col.names = F)
    write.table(result, 
                file = filename, 
                append = T,
                quote = F,
                sep = ",",
                row.names = T,
                col.names = F)
    write.table("", 
                file = filename,
                append = T,
                quote = F,
                sep = ",",
                row.names = F,
                col.names = F)
}

fun2(df[,c(5,1,2,3)], 3)

# 回帰分析のグラフのプロット
x <- c(1,2,3,2,7,5,9,1)
y <- c(14,20,21,15,36,27,40,8)
ans <- lm(y~x)

# 点のプロット
plot(x, y)

# 回帰直線のプロット
lines(x, fitted(ans), col = "red")
dev.off()  # 作図の終了コマンド

# プロットした図（グラフ）の保存
f1 <- "sample1.png"
f2 <- "sample2.jpeg"

png(f1, width = 800, height = 600)
plot(x,y)
lines(x, fitted(ans), col = "red")
dev.off()
plot(x, y)
lines(x, fitted(ans), col = "red")
dev.copy(jpeg, f2, width = 900, height = 675)
dev.off()

# パッケージのインストールの手順
install.packages("scatterplot3d")
install.packages("mvtnorm")

library(scatterplot3d)
library(mvtnorm)
