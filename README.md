* User
| column | data |
|:-|:-:|
|id|bigint|
|name|string|
|email|string|
|password_digest|string|


* Task
| column | data |
|:-|:-:|
|id|bigint|
|list|string|
|detail|string|
|status|string|
|deadline|date|
|priority|integer|
|user_id|bigint|
|label_id|bigint|


* Label
| column | data |
|:-|:-:|
|id|bigint|
|name|string|
|task_id|bigint|