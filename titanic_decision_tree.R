# Titanic decision tree practice
# https://rpubs.com/allan811118/R_programming_08
load("titanic.raw.rdata")


require(rpart)

# 先把資料區分成 train=0.8, test=0.2 
set.seed(22)
train.index <- sample(x=1:nrow(titanic.raw), size=ceiling(0.8*nrow(titanic.raw) ))
train <- titanic.raw[train.index, ]
test <- titanic.raw[-train.index, ]

# CART的模型：把存活與否的變數(Survived)當作Y，剩下的變數當作X
cart.model<- rpart(Survived ~. , 
                   data=train)

# 輸出各節點的細部資訊(呈現在console視窗)
cart.model
require(rpart.plot) 
prp(cart.model,         # 模型
    faclen=0,           # 呈現的變數不要縮寫
    fallen.leaves=TRUE, # 讓樹枝以垂直方式呈現
    shadow.col="gray",  # 最下面的節點塗上陰影
    # number of correct classifications / number of observations in that node
    extra=2)  
#
p_load(partykit)   
rparty.tree <- as.party(cart.model) # 轉換cart決策樹
rparty.tree # 輸出各節點的細部資訊
#
plot(rparty.tree) 



