install.packages("blme")
install.packages("optimx")
library(blme) #bayesian model with covert prior for covariance matrix
library(optimx) #optimizer
library("car")

pose_Rx <- read_csv("final/pose_Rx_mean.csv")
part_q_pose_Rx <- read_csv("final/part_q_pose_Rx_mean.csv")

inner <- read_csv("final/inner_pred_diff_mean.csv")
outer <- read_csv("final/outer_pred_diff_mean.csv")

part_q_inner <- read_csv("final/part_q_inner_pred_diff_mean.csv")
part_q_outer <- read_csv("final/part_q_outer_pred_diff_mean.csv")

# inner brows
inner$sType <- as.factor(inner$sType)

contrast <- cbind (c(0, 1/2, -1/2), c(2/3, -1/3, -1/3))   # gq partQ statement
colnames(contrast) <- c("+wh-st", "+polar")
contrasts (inner$sType) <- contrast

contrasts (inner$sType)

inner$deaf<-as.factor(inner$deaf)

contrast <- cbind (c(1/2, -1/2)) #deaf, hearing
colnames (contrast) <- c("+deaf")
contrasts (inner$deaf) <- contrast
contrasts(inner$deaf)

# for Noun
modelIntbN<-blmer(N_mean ~ sType * deaf + (sType|speaker_id) + (sType * deaf|sentence), data=inner, control = lmerControl(optimizer ='optimx', optCtrl=list(method='nlminb'))) #
summary(modelIntbN)
Anova(modelIntbN)

inner$predictedN<-predict(modelIntbN)
boxplot(predictedN~ sType * deaf, data=inner, las=2, xlab=" ")

# for Verb

modelIntbV<-blmer(V_mean ~ sType * deaf + (sType|speaker_id) + (sType * deaf|sentence), data=inner, control = lmerControl(optimizer ='optimx', optCtrl=list(method='nlminb'))) #
summary(modelIntbV)
Anova(modelIntbV)

inner$predictedV<-predict(modelIntbV)
boxplot(predictedV~ sType * deaf, data=inner, las=2, xlab=" ")

# outer brows

outer$sType <- as.factor(outer$sType)

contrast <- cbind (c(0, 1/2, -1/2), c(2/3, -1/3, -1/3))   # gq partQ statement
colnames(contrast) <- c("+wh-st", "+polar")
contrasts (outer$sType) <- contrast
contrasts (outer$sType)

outer$deaf<-as.factor(outer$deaf)

contrast <- cbind (c(1/2, -1/2)) #deaf, hearing
colnames (contrast) <- c("+deaf")
contrasts (outer$deaf) <- contrast
contrasts(outer$deaf)

# for Nouns
modelOutbN<-blmer(N_mean ~ sType * deaf + (sType|speaker_id) + (sType * deaf|sentence), data=outer, control = lmerControl(optimizer ='optimx', optCtrl=list(method='nlminb'))) #
summary(modelOutbN)
Anova(modelOutbN)

outer$predictedN<-predict(modelOutbN)
boxplot(predictedN~ sType * deaf, data=outer, las=2, xlab=" ")

# for Verbs
modelOutbV<-blmer(V_mean ~ sType * deaf + (sType|speaker_id) + (sType * deaf|sentence), data=outer, control = lmerControl(optimizer ='optimx', optCtrl=list(method='nlminb'))) #
summary(modelOutbV)
Anova(modelOutbV)

outer$predictedV<-predict(modelOutbV)
boxplot(predictedV~ sType * deaf, data=outer, las=2, xlab=" ")

# pose_Rx
pose_Rx$sType <- as.factor(pose_Rx$sType)

contrast <- cbind (c(0, 1/2, -1/2), c(2/3, -1/3, -1/3))   # gq partQ statement
colnames(contrast) <- c("+wh-st", "+polar")
contrasts (pose_Rx$sType) <- contrast
contrasts (pose_Rx$sType)

pose_Rx$deaf<-as.factor(pose_Rx$deaf)

contrast <- cbind (c(1/2, -1/2)) #deaf, hearing
colnames (contrast) <- c("+deaf")
contrasts (pose_Rx$deaf) <- contrast
contrasts(pose_Rx$deaf)

# for Nouns
modelPoseN<-blmer(N_mean ~ sType * deaf + (sType|speaker_id) + (sType * deaf|sentence), data=pose_Rx, control = lmerControl(optimizer ='optimx', optCtrl=list(method='nlminb'))) #
summary(modelPoseN)
Anova(modelPoseN)

pose_Rx$predictedN<-predict(modelPoseN)
boxplot(predictedN~ sType * deaf, data=pose_Rx, las=2, xlab=" ")

# for Verbs
modelPoseV<-blmer(V_mean ~ sType * deaf + (sType|speaker_id) + (sType * deaf|sentence), data=pose_Rx, control = lmerControl(optimizer ='optimx', optCtrl=list(method='nlminb'))) #
summary(modelPoseV)
Anova(modelPoseV)

pose_Rx$predictedV<-predict(modelPoseV)
boxplot(predictedV~ sType * deaf, data=pose_Rx, las=2, xlab=" ")

# part_q inner
part_q_inner$pos <- as.factor(part_q_inner$pos)

contrast <- cbind (c(1/2, 0, -1/2), c(-1/3, 2/3, -1/3))   # N Q V
colnames(contrast) <- c("+N-V", "+Q")
contrasts (part_q_inner$pos) <- contrast
contrasts (part_q_inner$pos)

part_q_inner$deaf<-as.factor(part_q_inner$deaf)
part_q_inner$mean<-as.numeric(part_q_inner$mean)

contrast <- cbind (c(1/2, -1/2)) #deaf, hearing
colnames (contrast) <- c("+deaf")
contrasts (part_q_inner$deaf) <- contrast
contrasts(part_q_inner$deaf)

# for pos
modelIntPQ<-blmer(mean ~ pos * deaf + (pos|speaker_id) + (pos * deaf|sentence), data=part_q_inner, control = lmerControl(optimizer ='optimx', optCtrl=list(method='nlminb'))) #
summary(modelIntPQ)
Anova(modelIntPQ)

part_q_inner$predicted<-predict(modelIntPQ)
boxplot(predicted ~ pos * deaf, data=part_q_inner, las=2, xlab=" ")

# part_q outer
part_q_outer$pos <- as.factor(part_q_outer$pos)

contrast <- cbind (c(1/2, 0, -1/2), c(-1/3, 2/3, -1/3))   # N Q V
colnames(contrast) <- c("+N-V", "+Q")
contrasts (part_q_outer$pos) <- contrast
contrasts (part_q_outer$pos)

part_q_outer$deaf<-as.factor(part_q_outer$deaf)
part_q_outer$mean<-as.numeric(part_q_outer$mean)

contrast <- cbind (c(1/2, -1/2)) #deaf, hearing
colnames (contrast) <- c("+deaf")
contrasts (part_q_outer$deaf) <- contrast
contrasts(part_q_outer$deaf)

# for pos
modelOutPQ<-blmer(mean ~ pos * deaf + (pos|speaker_id) + (pos * deaf|sentence), data=part_q_outer, control = lmerControl(optimizer ='optimx', optCtrl=list(method='nlminb'))) #
summary(modelOutPQ)
Anova(modelOutPQ)

part_q_outer$predicted<-predict(modelOutPQ)
boxplot(predicted ~ pos * deaf, data=part_q_outer, las=2, xlab=" ")

# part_q pose_Rx
part_q_pose_Rx$pos <- as.factor(part_q_pose_Rx$pos)

contrast <- cbind (c(1/2, 0, -1/2), c(-1/3, 2/3, -1/3))   # N Q V
colnames(contrast) <- c("+N-V", "+Q")
contrasts (part_q_pose_Rx$pos) <- contrast
contrasts (part_q_pose_Rx$pos)

part_q_pose_Rx$deaf<-as.factor(part_q_pose_Rx$deaf)

contrast <- cbind (c(1/2, -1/2)) #deaf, hearing
colnames (contrast) <- c("+deaf")
contrasts (part_q_pose_Rx$deaf) <- contrast
contrasts(part_q_pose_Rx$deaf)

# for pos
modelPQPose<-blmer(mean ~ pos * deaf + (pos|speaker_id) + (pos * deaf|sentence), data=part_q_pose_Rx, control = lmerControl(optimizer ='optimx', optCtrl=list(method='nlminb'))) #
summary(modelPQPose)
Anova(modelPQPose)

part_q_pose_Rx$predicted<-predict(modelPQPose)
boxplot(predicted ~ pos * deaf, data=part_q_pose_Rx, las=2, xlab=" ")
