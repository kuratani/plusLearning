@IsTest
private class LearningContentServiceTest {

    static testMethod void testRecommend1() {
        LearningContent__c content = new LearningContent__c();
        content.Name = '学習コンテンツ';
        content.TargetSkill__c = 'プログラミング';
        insert content;
        
        Profile p = [SELECT Id, Name FROM Profile WHERE Name IN ('システム管理者', 'System Admin') LIMIT 1];

        User u = new User(
            FirstName='太郎',
            LastName='山田',
            InterestingSkill__c='プログラミング',
            Username='pl_test_user1@example.com',
            Email='pl_test_user1@example.com',
            Alias='山田 太郎',
            CommunityNickname='pl_test_user1',
            EmailEncodingKey='ISO-2022-JP',
            TimeZoneSidKey='Asia/Tokyo',
            LocaleSidKey='ja_JP',
            LanguageLocaleKey='ja',
            ProfileId=p.Id);
        insert u;
        LearningContentService.recommend(content.Id);
 
        List<LearningLog__c> logs = [SELECT Id, Name FROM LearningLog__c WHERE OwnerId = :u.Id];
        System.assertEquals(1, logs.size());
    }

    static testMethod void testRecommend2() {
        LearningContent__c content = new LearningContent__c();
        content.Name = '学習コンテンツ';
        content.TargetSkill__c = 'エンジニアリング';
        insert content;
        
        Profile p = [SELECT Id, Name FROM Profile WHERE Name IN ('システム管理者', 'System Admin') LIMIT 1];

        User u = new User(
            FirstName='太郎',
            LastName='山田',
            InterestingSkill__c='プログラミング',
            Username='pl_test_user1@example.com',
            Email='pl_test_user1@example.com',
            Alias='山田 太郎',
            CommunityNickname='pl_test_user1',
            EmailEncodingKey='ISO-2022-JP',
            TimeZoneSidKey='Asia/Tokyo',
            LocaleSidKey='ja_JP',
            LanguageLocaleKey='ja',
            ProfileId=p.Id);
        insert u;
        LearningContentService.recommend(content.Id);
 
        List<LearningLog__c> logs = [SELECT Id, Name FROM LearningLog__c WHERE OwnerId = :u.Id];
        System.assertEquals(0, logs.size());
    }

    static testMethod void testAssign1() {
        LearningContent__c content = new LearningContent__c();
        content.Name = '学習コンテンツ';
        content.TargetSkill__c = '';
        insert content;
        
        Profile p = [SELECT Id, Name FROM Profile WHERE Name IN ('システム管理者', 'System Admin') LIMIT 1];

        User u = new User(
            FirstName='太郎',
            LastName='山田',
            InterestingSkill__c='プログラミング',
            Username='pl_test_user1@example.com',
            Email='pl_test_user1@example.com',
            Alias='山田 太郎',
            CommunityNickname='pl_test_user1',
            EmailEncodingKey='ISO-2022-JP',
            TimeZoneSidKey='Asia/Tokyo',
            LocaleSidKey='ja_JP',
            LanguageLocaleKey='ja',
            ProfileId=p.Id);
        insert u;
        LearningContentService.assign(content.Id);
 
        List<LearningLog__c> logs = [SELECT Id, Name FROM LearningLog__c WHERE OwnerId = :u.Id];
        System.assertEquals(1, logs.size());
    }

}