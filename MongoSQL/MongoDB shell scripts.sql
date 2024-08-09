-- 模板
db.getCollection("etl_generalSupervision_supervisionInteractionRecord").aggregate([
	{$match:{}},
	{$project:{}},
	{$limit:{}}
])

-- 只查看 result 字段
db.getCollection("etl_generalSupervision_supervisionInteractionRecord").aggregate([
    { $match: { "result": { $exists: true } } },
    { $project: { "_id": 0, "result": 1 } },
    { $limit: 50 }
])

-- 返回该字段（array 类型）长度不为0的数据
db.getCollection("etl_generalSupervision_supervisionBehavior").aggregate([
    {
        $match: {
            "judgmentResultData.correctedInfo": { $exists: true, $not: { $size: 0 } }
        }
    }
])

-- 查看 triggerTimePoint 字段
db.getCollection("etl_generalSupervision_supervisionInteractionRecord").aggregate([
    {
        $match: {
            "triggerTimePoint": { $ne: 0 }
        }
    },
    {
        $project: {
            "_id": 1,
            "triggerTimePoint": 1
        }
    }
])

-- 查看用户活跃天数是否存在值
db.getCollection("etl_generalSupervision_userSupervisionFact").aggregate([
    {
        $match: {
            "basicFactData.dataValue.activityDateList": { $exists: true }
        }
    },
    {
        $project: {
            "_id": 1,
            "basicFactData.dataValue.activityDateList": 1
        }
    }
])
