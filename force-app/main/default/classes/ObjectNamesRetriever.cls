public  with sharing class ObjectNamesRetriever {
    @AuraEnabled(cacheable=true)
    public static List<String> getAllObjectNames() {
        List<String> objectNames = new List<String>();
        
        List<EntityDefinition> schemaMap = [SELECT Label FROM EntityDefinition WHERE IsCustomizable = true  ];
        for (EntityDefinition objectName : schemaMap) {
            objectNames.add(objectName.Label);
        }
        return  objectNames;
    }
    @AuraEnabled(Cacheable=false)
    public static Id CreateDocumentInsight(String objectName,String TemplateName ,Id fileContent ) {
        System.debug('dd--->'+fileContent);
        Document_Insight_Template__c newTemplate = new Document_Insight_Template__c(); 
        String jsonString3 = '[{"sPossibleKey":"NPI:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"TIN:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Please FAX Completed Form to:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Policyholder Name:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Policyholder Date of Birth (mm/dd/yyyy):","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Company and Plan Name:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Self","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Spouse","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Group #:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Other","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Member Id#:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Healthcare Organization Name*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Provider Name (First Name, Last Name)*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"NPI*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Address*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"City*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"State*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Zip*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Phone Number*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Secure Fax Number*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Email*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Z12.11 (Colon)","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Z12.12 (Rectum)","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Other(s)","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"type:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Sample source:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"If the patient has had a Colorectal Cancer (CRC) Screening in the past, please provide the date of the last screening:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Colonoscopy","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"DNA-Fit Test","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"FIT Test","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"mRNA (e.g. Colosense)","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Other","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Patient Name* (First, Middle, Last):","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Date of Birth* (mm/dd/yyyy):","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Male","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Female","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Mobile Phone*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Email:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"English","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Spanish","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Other","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Type 2 Diabetes Mellitus","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Cardiovascular Disease","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Obesity","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Yes","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"No","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"White","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Black or African-American","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Asian","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Native Hawaiian or Pacific Islander","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"American Indian or Alaska Native","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"NPI:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"TIN:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Provider Signature*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Date of Order*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Date Sample Collected:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Date Sample Received:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Kit ID:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"NPI:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"TIN:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"P:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false}]';
    //Call API 
   
// Replace line breaks and whitespace with an empty string
String singleLineString = jsonString3.replaceAll('\\s', '');
    newTemplate.Name = TemplateName;
        newTemplate.Source_feild_mapping__c =jsonString3; 
        newTemplate.Source_Object__c = objectName;
        
        
        try {
            
            insert newTemplate;
            
            ContentDocumentLink contentLink = new ContentDocumentLink();
            contentLink.ContentDocumentId =fileContent ;
            contentLink.LinkedEntityId = newTemplate.Id;
            contentLink.ShareType = 'V'; 
            
            insert contentLink;
        
            return newTemplate.Id;
        } catch (DMLException e) {
            System.debug('Error creating Template record: ' + e);
            return JSON.serialize(e);
        }       
    }
    @AuraEnabled(cacheable=true)
    public static List<FieldDescribeInfo> getFieldDescribeInfo( String SelectedObject) {
        List<FieldDescribeInfo> fieldInfoList = new List<FieldDescribeInfo>();
        Schema.DescribeSObjectResult describeResult = Schema.getGlobalDescribe().get(SelectedObject).getDescribe();
        Map<String, Schema.SObjectField> fieldMap = describeResult.fields.getMap();
        for (String fieldName : fieldMap.keySet()) {
            Schema.DescribeFieldResult fieldDescribe = fieldMap.get(fieldName).getDescribe();
            FieldDescribeInfo fieldInfo = new FieldDescribeInfo(
                fieldDescribe.getName(),
                fieldDescribe.getLabel(),
                fieldDescribe.getType().name()
            );
            fieldInfoList.add(fieldInfo);
        }
        
        return fieldInfoList;
    }
    
    /*public static List<FieldDescribeInfo> getParentDescribeInfo( String SelectedObject) {
        List<FieldDescribeInfo> fieldInfoList = new List<FieldDescribeInfo>();
        Schema.DescribeSObjectResult describeResult = Schema.getGlobalDescribe().get(SelectedObject).getDescribe();
        Map<String, Schema.SObjectField> fieldMap = describeResult.fields.getMap();
        for (String fieldName : fieldMap.keySet()) {
            Schema.DescribeFieldResult fieldDescribe = fieldMap.get(fieldName).getDescribe();
            FieldDescribeInfo fieldInfo = new FieldDescribeInfo(
                fieldDescribe.getName(),
                fieldDescribe.getLabel(),
                fieldDescribe.getType().name()
            );
            fieldInfoList.add(fieldInfo);
        }
        
        return fieldInfoList;
    }*/
    
    public class FieldDescribeInfo {
        @AuraEnabled
        public String fieldName { get; set; }
        @AuraEnabled
        public String fieldLabel { get; set; }
        @AuraEnabled
        public String fieldType { get; set; }
        
        public FieldDescribeInfo(String fieldName, String fieldLabel, String fieldType) {
            this.fieldName = fieldName;
            this.fieldLabel = fieldLabel;
            this.fieldType = fieldType;
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static String getApiResposne( ) {
        //String jsonString = '"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Patient Address","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Patient Type","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false}]';
        String jsonString2 = '[{"sPossibleKey":"Provider Name (First Name, Last Name) *:","sObjectName":"AccountId","sDataType":"Text","sFieldAPIName":"Name","sPicklistValue":"","isParent":true,"linkRecord":false},{"sPossibleKey":"OCT~DCT~CT~XCT","sObjectName":"Contact","sDataType":"Picklist","sFieldAPIName":"Level__c","sPicklistValue":"new","isParent":false,"linkRecord":false},{"sPossibleKey":"Type 2 Diabetes Mellitus~|TypeDiabetes Mellitus","sObjectName":"AccountId","sDataType":"Picklist","sFieldAPIName":"AccountSource","sPicklistValue":"new","isParent":true,"linkRecord":false}]';
        
      String jsonString = '[{"sPossibleKey":"NPI:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"TIN:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Please FAX Completed Form to:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Policyholder Name:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Policyholder Date of Birth (mm/dd/yyyy):","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Company and Plan Name:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Self","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Spouse","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Group #:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Other","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Member Id#:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Healthcare Organization Name*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Provider Name (First Name, Last Name)*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"NPI*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Address*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"City*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"State*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Zip*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Phone Number*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Secure Fax Number*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Email*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Z12.11 (Colon)","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Z12.12 (Rectum)","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Other(s)","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"type:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Sample source:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"If the patient has had a Colorectal Cancer (CRC) Screening in the past, please provide the date of the last screening:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Colonoscopy","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"DNA-Fit Test","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"FIT Test","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"mRNA (e.g. Colosense)","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Other","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Patient Name* (First, Middle, Last):","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Date of Birth* (mm/dd/yyyy):","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Male","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Female","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Mobile Phone*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Email:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"English","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Spanish","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Other","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Type 2 Diabetes Mellitus","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Cardiovascular Disease","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Obesity","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Yes","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"No","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"White","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Black or African-American","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Asian","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Native Hawaiian or Pacific Islander","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"American Indian or Alaska Native","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"NPI:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"TIN:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Provider Signature*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Date of Order*:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Date Sample Collected:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Date Sample Received:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"Kit ID:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"NPI:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"TIN:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false},{"sPossibleKey":"P:","sObjectName":"","sDataType":"","sFieldAPIName":"","sPicklistValue":"","isParent":false,"linkRecord":false}]';

// Replace line breaks and whitespace with an empty string
String singleLineString = jsonString.replaceAll('\\s', '');


 
        return singleLineString;
        
    }
    
    @AuraEnabled(cacheable=true)
    public static List<FieldDescribeInfo> getReferenceObjectFields(String objectName, String fieldName) {
     String Obj=getReferencedObjectName(objectName,fieldName);
     
        return getFieldDescribeInfo(Obj);
        
    }
    @AuraEnabled(cacheable=true)
    public static string getPicklistFeildValues( String SelectedObject, String fieldname) {
        System.debug('obj---->'+SelectedObject+'----->'+fieldname);
        List<String> picklistValues = new List<String>();
        
        try {
            // Get the SObject type
            SObjectType objectType = Schema.getGlobalDescribe().get(SelectedObject);
            if (objectType != null) {
                // Get the field describe result
                Map<String, Schema.SObjectField> fieldMap = objectType.getDescribe().fields.getMap();
                Schema.DescribeFieldResult fieldDescribe = fieldMap.get(fieldName).getDescribe();
                
                // Check if the field type is "picklist"
                if (fieldDescribe.getType() == Schema.DisplayType.Picklist || fieldDescribe.getType() == Schema.DisplayType.MULTIPICKLIST) {
                    // Get the picklist values
                    List<Schema.PicklistEntry> picklistEntries = fieldDescribe.getPicklistValues();
                    for (Schema.PicklistEntry entry : picklistEntries) {
                        picklistValues.add(entry.getValue());
                    }
                }
            }
        } catch (Exception e) {
            // Handle any exceptions, e.g., invalid object or field names
            System.debug('Error: ' + e.getMessage());
        }
        
        
        
        return JSON.serialize(picklistValues);
        
        
        
    }
    @AuraEnabled(cacheable=true)
    public static string getParentPicklistFeildValues( String SelectedObject, String fieldname) {
        
        Map<String, List<String>> picklistMap = new Map<String, List<String>>();
        
        // Get the SObject Describe for the specified object
        Schema.DescribeSObjectResult describeResult = Schema.getGlobalDescribe().get(SelectedObject).getDescribe();
        
        // Iterate through the fields on the object
        for (Schema.SObjectField field : describeResult.fields.getMap().values()) {
            Schema.DescribeFieldResult fieldDescribe = field.getDescribe();
            
            // Check if the field is a picklist
            
            List<String> picklistValues = new List<String>();
            
            // Get the picklist values
            for (Schema.PicklistEntry entry : fieldDescribe.getPicklistValues()) {
                if(entry!=null){
                    
                    picklistValues.add(entry.getValue());
                }
                
                
                // Add the picklist field and its values to the map
                picklistMap.put(fieldDescribe.getName(), picklistValues);
            }
        }
        
        return JSON.serialize(picklistMap);
        
        
        
    }
    @AuraEnabled(cacheable=true)
    public static String getFieldType(String objectName, String fieldName) {
        try {
            
            
            // Describe the object
            Schema.SObjectType objectType = Schema.getGlobalDescribe().get(objectName);
            
            if (objectType != null) {
                // Describe the field
                Schema.DescribeSObjectResult objectDescribe = objectType.getDescribe();
                Schema.SObjectField field = objectDescribe.fields.getMap().get(fieldName);
                
                if (field != null) {
                    Schema.DescribeFieldResult fieldDescribe = field.getDescribe();
                    return fieldDescribe.getType().name();
                }
            }
        } catch (Exception e) {
            // Handle any exceptions here
        }
        
        return null; // Field not found or not present in the object
    }
    @AuraEnabled(cacheable=true)
    public static String getReferencedObjectName(String objectName, String fieldName) {
        System.debug(objectName + '---->' + fieldName);
        String referencedObject = '';
        Schema.DescribeSObjectResult sourceObjDescribe = Schema.getGlobalDescribe().get(objectName).getDescribe();
        Schema.SObjectField sourceField = sourceObjDescribe.fields.getMap().get(fieldName);
        
        if (sourceField.getDescribe().getType() == Schema.DisplayType.REFERENCE) {
            referencedObject = String.valueOf(sourceField.getDescribe().getReferenceTo()[0]);
        }
        
        return referencedObject;
    }
    
    
    @AuraEnabled
    public static String updateRecord(Id recordId, String newValue) {
        try {
            
            
            
            List<Document_Insight_Template__c> lstRecord =[SELECT Id, Source_feild_mapping__c FROM Document_Insight_Template__c WHERE Id = :recordId LIMIT 1];
            
            
            
            if (lstRecord != null && lstRecord.size()>0) {
                lstRecord[0].Source_feild_mapping__c = newValue;
                
                update lstRecord;
                
                return 'Record updated successfully.';
            } else {
                System.debug('Record not found.');
                return 'Record not found.';
                
            }
            
        } catch (Exception e) {
            return 'Error: ' + e.getMessage();
        }
    }
    
    @AuraEnabled
    public static List<Document_Insight_Template__c> FetchRecord(String recordId) {
        System.debug('lst---->'+recordId); 
        List<String> value = new List<String>();
        value.add(recordId);
        String temp = value[0].replace('"', '\'');
        String query = 'SELECT Name, Source_feild_mapping__c,Source_Object__c FROM Document_Insight_Template__c WHERE Id = ' + temp;
        System.debug('Query->' + query);
        List<Document_Insight_Template__c>lst =Database.query(query);
        System.debug('lst---->'+lst);
        return lst;
    }
    @AuraEnabled
    public static List<Document_Insight_Template__c> FetchRecord2(Id recordId) {
        
        List<Document_Insight_Template__c>lst =  [SELECT Name, Source_feild_mapping__c,Source_Object__c FROM Document_Insight_Template__c WHERE Id= :recordId LIMIT 1];
        System.debug('lst---->'+lst);
        return lst;
    }
    
    
    
    
}