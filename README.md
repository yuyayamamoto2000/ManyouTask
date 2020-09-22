# README

#Task

|  カラム名  |    データ型   |
----|----
| id          | integer  |
| title       | string   |
| content     | string   |
| created_at  | datetime |
| updated_at  | datetime |


#User

|  カラム名  |    データ型   |
----|----
| id              | integer   |
| name            | string   |
| email           | string   |
| password_digest | string |

#Label

|  カラム名  |    データ型   |
----|----
| id   | integer |
| name | string  |

#Labelling

|  カラム名  |    データ型   |
----|----
| id        | integer |
| task_id   | integer |
| label_id  | integer |
