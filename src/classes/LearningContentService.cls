global class LearningContentService {

    webService static boolean recommend(Id learningContentId) {
        List<LearningLog__c> logs = new List<LearningLog__c>();
 
         LearningContent__c content = [SELECT Id, Name, TargetSkill__c FROM LearningContent__c WHERE Id = :learningContentId LIMIT 1];
 
        for(User user : [SELECT Id, Name, InterestingSkill__c FROM User WHERE IsActive=true AND UserType IN ('標準', 'Standard')]) {
            if(user.InterestingSkill__c != null && user.InterestingSkill__c.contains(content.TargetSkill__c)) {
                LearningLog__c log = new LearningLog__c();
                log.OwnerId = user.id;
                log.Name = '学習記録' + content.Name + ' ' + user.Name;
                log.LearningContent__c = content.Id;
                log.Status__c = 'おすすめ！';
                logs.add(log);
            }
        }

        if(logs.size() > 0) Database.insert(logs);
        
        return true;
    }

    webService static boolean assign(Id learningContentId) {
        List<LearningLog__c> logs = new List<LearningLog__c>();
 
         LearningContent__c content = [SELECT Id, Name, TargetSkill__c FROM LearningContent__c WHERE Id = :learningContentId LIMIT 1];
 
        for(User user : [SELECT Id, Name, InterestingSkill__c FROM User WHERE IsActive=true AND UserType IN ('標準', 'Standard')]) {
            LearningLog__c log = new LearningLog__c();
            log.OwnerId = user.id;
            log.Name = '学習記録' + content.Name + ' ' + user.Name;
            log.LearningContent__c = content.Id;
            log.Status__c = 'おすすめ！';
            logs.add(log);
        }

        if(logs.size() > 0) Database.insert(logs);
        
        return true;
    }
 }