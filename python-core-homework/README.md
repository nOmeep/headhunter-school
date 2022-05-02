[![Tests](https://github.com/nOmeep/python-core-homework/actions/workflows/python-app.yml/badge.svg?branch=master)](https://github.com/username/python-core-homework/actions/workflows/python-app.yml)

# Настройка Github репозитория

### Fork

Форкнуть [репозиторий с домашкой](https://github.com/sabkaryan/python-core-homework)

### Включить Actions в своём форке

<img width="1377" alt="Screenshot 2022-01-12 at 17 13 36" src="https://user-images.githubusercontent.com/1016430/149178275-123c3a73-27c8-48af-afaa-066a1a3c634c.png">

1. Перейти на гитхабе в форкнутый репозиторий (ссылка
   вида `https://github.com/ваше_имяпользователя/python-core-homework`)

2. Перейти во вкладку Actions и нажать на кнопку `I understand my workflows, go ahead and enable them` :)


### Настроить бейдж

<img width="136" alt="Screenshot 2022-01-12 at 18 36 35" src="https://user-images.githubusercontent.com/1016430/149177582-02c9a54f-1a9a-4a21-a9a8-6e4fdbb33c0f.png">
    
Открыть файл [README.md](README.md) заменить первую строку
```
[![Tests](https://github.com/sabkaryan/python-core-homework/actions/workflows/python-app.yml/badge.svg?branch=master)](https://github.com/sabkaryan/python-core-homework/actions/workflows/python-app.yml)
```   
на
```
[![Tests](https://github.com/username/python-core-homework/actions/workflows/python-app.yml/badge.svg?branch=master)](https://github.com/username/python-core-homework/actions/workflows/python-app.yml)
```
где username - ваше_имяпользователя_на_github
Теперь при пуше или мёрдже в master будут прогоняться юнит-тесты и бейдж будет показывать их состояние

---

# Requirements

- Python версии 3.8 или старше

# Run

Для каждого упражнения написаны юнит тесты, которые лежат в папке [tests](tests)

Для запуска всех тестов

- перейти в директорию проекта
- в консоле ввести

```
python -m unittest
```

---

# Exercise 1

Написать функцию `build_roles_tree`, которая переводит данные маппинга ролей в категории в древовидную структуру

- код [Exercise 1](ex1/__init__.py)
- запуск тестов первого упражнения

```
python -m unittest test_ex1.TestRolesTree
```

### Термины

- Роль - профессиональная роль пользователя (Автомойщик, Автослесарь, Курьер и тд)
- Категория - профессиональная область, в которую входят роли (Автомобильный бизнес, Административный персонал, Высший
  менеджмент и тд)

### Структура маппинга:

```python
{
    "roles": {
        "1": {"id": "1", "name": "Text1"},
        "2": {"id": "2", "name": "Text2"},
    },
    "categories": {
        "category-1": {"id": "category-1", "name": "Category Text 1", "roleIds": ["1", "2"]},
        "category-2": {"id": "category-2", "name": "Category Text 2", "roleIds": ["3", "4"]}
    },
    "categoryIdsSorted": ["category-1", "category-2"],
}
```

- `roles` - словарь ролей
    * ключ - `id` роли
    * значение - словарь вида
      ```python
      {
        "id": "1", # id роли 
        "name": "Text1" # имя роли
      }
      ```
- `categories` - словарь категорий
    * ключ - `id` категории
    * значение - словарь вида
      ```python
      {
        "id": "category-1", # id категории
        "name": "Category Text 1", # имя категории
        "roleIds": ["1", "2"] # отсортированный список `id` ролей, входящих в категорию
      }
      ```
- `categoryIdsSorted` - список `id` категорий, представляющий порядок сортировки

### Дерево ролей

Функция `build_roles_tree` должна вернуть древовидную структура вида

```python
{
    "categories": [
        {
            "id": "category-19",  # идентификатор вида `category-{id_категории}`
            "text": "Автомобильный бизнес",  # имя категории
            "items":  # список ролей, входящих в категорию
                [
                    {"id": "4", "text": "Автомойщик"},
                    {"id": "5", "text": "Автослесарь, автомеханик"},
                    {"id": "62", "text": "Мастер-приемщик"},
                    {
                        "id": "70",  # id роли
                        "text": "Менеджер по продажам, менеджер по работе с клиентами",  # имя роли
                    },
                ],
        },
    ]
}
```

---

# Exercise 2

Написать реализацию декоратора `benchmark`, который на вход принимает количество прогонов `num` оборачиваемой
функции `func`, совершает `num` прогонов `func` и выводит в консоль время каждого прогона и среднее время всех прогонов.

`среднее_время = сумарное_время_всех_прогонов / num`

- код [Exercise 2](ex2/__init__.py)
- запуск тестов второго упражнения

```
python -m unittest test_ex2.TestFetchPage
```

---

# Exercise 3

В этом упражнении вам предстоит реализовать игру Камень, ножницы, бумага. Функция определения победителя уже
реализована [determine_winner](ex3/__init__.py). Допишите недостающий код.

Запуск тестов третьего упражнения

```
python -m unittest test_ex3.TestGame
```

---

# Exercise 4

Написать реализацию функции `cross_join`, которая возвращает генератор пар `(LastName, DepartmentName)`
аналогичных результату запроса

```sql
SELECT LastName, DepartmentName
FROM Employee,
     Department
```

`Employee table`

| LastName   | DepartmentID |
|------------|-------------:|
| Rafferty   |           31 |
| Jones      |           33 |
| Heisenberg |           33 |
| Robinson   |           34 |
| Smith      |           34 |
| Williams   |           31 |

`Department table`

| DepartmentID | DepartmentName  |
| ------------ | --------------: |
| 31           | Sales           |
| 33           | Engineering     |
| 34           | Clerical        |
| 35           | Marketing       |

- код [Exercise 4](ex4/__init__.py)
- запуск тестов четвёртого упражнения

```
python -m unittest test_ex4.TestCrossJoin
```

