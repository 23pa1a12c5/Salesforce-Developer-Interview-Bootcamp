# SOQL Queries

## Get All Vehicles

```sql
SELECT Id, Name FROM Vehicle__c
```

## Get Vehicle By Name

```sql
SELECT Id, Name
FROM Vehicle__c
WHERE Name = 'Honda'
```

## Order Vehicles

```sql
SELECT Id, Name
FROM Vehicle__c
ORDER BY Name
```

## Count Vehicles

```sql
SELECT COUNT()
FROM Vehicle__c
```
