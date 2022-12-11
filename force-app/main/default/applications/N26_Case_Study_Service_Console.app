<?xml version="1.0" encoding="UTF-8"?>
<CustomApplication xmlns="http://soap.sforce.com/2006/04/metadata">
    <actionOverrides>
        <actionName>View</actionName>
        <comment>Action override created by Lightning App Builder during activation.</comment>
        <content>Case_Record_Page</content>
        <formFactor>Large</formFactor>
        <skipRecordTypeSelect>false</skipRecordTypeSelect>
        <type>Flexipage</type>
        <pageOrSobjectType>Case</pageOrSobjectType>
    </actionOverrides>
    <actionOverrides>
        <actionName>View</actionName>
        <comment>Action override created by Lightning App Builder during activation.</comment>
        <content>Case_Record_Page</content>
        <formFactor>Small</formFactor>
        <skipRecordTypeSelect>false</skipRecordTypeSelect>
        <type>Flexipage</type>
        <pageOrSobjectType>Case</pageOrSobjectType>
    </actionOverrides>
    <brand>
        <headerColor>#0070D2</headerColor>
        <logo>Logo1</logo>
        <logoVersion>1</logoVersion>
        <shouldOverrideOrgTheme>false</shouldOverrideOrgTheme>
    </brand>
    <description>This is a console app for one screen case management</description>
    <formFactors>Small</formFactors>
    <formFactors>Large</formFactors>
    <isNavAutoTempTabsDisabled>false</isNavAutoTempTabsDisabled>
    <isNavPersonalizationDisabled>false</isNavPersonalizationDisabled>
    <isNavTabPersistenceDisabled>false</isNavTabPersistenceDisabled>
    <label>N26 Case Study Service Console</label>
    <navType>Console</navType>
    <tabs>standard-Account</tabs>
    <tabs>standard-Case</tabs>
    <tabs>standard-Contact</tabs>
    <tabs>standard-Product2</tabs>
    <tabs>Card_Charge__c</tabs>
    <uiType>Lightning</uiType>
    <utilityBar>N26_Case_Study_Service_Console_UtilityBar</utilityBar>
    <workspaceConfig>
        <mappings>
            <tab>Card_Charge__c</tab>
        </mappings>
        <mappings>
            <tab>standard-Account</tab>
        </mappings>
        <mappings>
            <fieldName>AccountId</fieldName>
            <tab>standard-Case</tab>
        </mappings>
        <mappings>
            <tab>standard-Contact</tab>
        </mappings>
        <mappings>
            <tab>standard-Product2</tab>
        </mappings>
    </workspaceConfig>
</CustomApplication>
