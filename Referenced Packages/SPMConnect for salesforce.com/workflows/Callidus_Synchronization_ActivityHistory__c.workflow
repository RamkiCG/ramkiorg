<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Callidus_Synchronization_Process_completed_successfully</fullName>
        <description>Callidus Synchronization Process completed successfully</description>
        <protected>true</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Callidus_SPMConnect/Synchronization_Process_Completed</template>
    </alerts>
    <rules>
        <fullName>Callidus Syncrhonization Process completed successfully</fullName>
        <actions>
            <name>Callidus_Synchronization_Process_completed_successfully</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Callidus_Synchronization_ActivityHistory__c.Status__c</field>
            <operation>equals</operation>
            <value>Success</value>
        </criteriaItems>
        <criteriaItems>
            <field>Callidus_Synchronization_ActivityHistory__c.Synchronization_Record_Details_Count__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
