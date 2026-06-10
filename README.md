# Territorial.io - Roblox Strategy Game

## Описание проекта
Многопользовательская стратегия захвата территорий с картой мира, разделенной на регионы. Игроки захватывают территории, управляют ресурсами и строят здания.

## 🗂️ Структура проекта в Roblox Studio

```
Workspace
├── Camera
├── Terrain
├── Baseplate
├── Texture
├── Players
├── Lighting
├── Atmosphere
├── Sky
├── Bloom
├── DepthOfField
├── SunRays
├── MaterialService
├── ReplicatedFirst
├── ReplicatedStorage
│   ├── Config.lua
│   ├── Constants.lua
│   ├── Types.lua
│   ├── Utils.lua
│   ├── TopBar.lua
│   ├── TerritoryInfoPanel.lua
│   ├── BuildMenu.lua
│   ├── Leaderboard.lua
│   └── MapController.lua
├── ServerScriptService
│   ├── Main.lua (Script)
│   ├── Managers (Folder)
│   │   ├── Config.lua
│   │   ├── Constants.lua
│   │   ├── Utils.lua
│   │   ├── TerritoryManager.lua
│   │   ├── ResourceManager.lua
│   │   ├── CombatSystem.lua
│   │   ├── BuildingSystem.lua
│   │   └── GameManager.lua
│   └── Services (Folder)
│       └── NetworkHandler.lua
├── ServerStorage
├── StarterGui
│   └── ScreenGui (автоматически создан Client/Main.lua)
├── StarterPack
├── StarterPlayer
│   ├── StarterPlayerScripts (Folder)
│   │   └── Main.lua (LocalScript для клиента)
│   └── StarterCharacterScripts
├── Teams
├── SoundService
├── TextChatService
└── BubbleChatConfiguration
```

## 📦 Как установить в Roblox Studio

### Шаг 1: Скопировать файлы конфигурации в ReplicatedStorage

1. Откройте Roblox Studio и создайте новый проект
2. Щелкните правой кнопкой на **ReplicatedStorage** → Insert Object → LocalScript
3. Удалите LocalScript и скопируйте туда следующие файлы:

**Из папки src/Shared/**
- `Config.lua` → ReplicatedStorage
- `Constants.lua` → ReplicatedStorage
- `Types.lua` → ReplicatedStorage
- `Utils.lua` → ReplicatedStorage

**Из папки src/Client/UI/**
- `TopBar.lua` → ReplicatedStorage
- `TerritoryInfoPanel.lua` → ReplicatedStorage
- `BuildMenu.lua` → ReplicatedStorage
- `Leaderboard.lua` → ReplicatedStorage

**Из папки src/Client/Controllers/**
- `MapController.lua` → ReplicatedStorage

### Шаг 2: Создать папку Managers в ServerScriptService

1. Щелкните правой кнопкой на **ServerScriptService** → Insert Object → Folder
2. Назовите папку **Managers**
3. Скопируйте туда следующие файлы:

**Из папки src/Server/Managers/**
- `TerritoryManager.lua`
- `ResourceManager.lua`
- `CombatSystem.lua`
- `BuildingSystem.lua`
- `GameManager.lua`

**Также из папки src/Shared/ (скопируйте еще раз в Managers)**
- `Config.lua`
- `Constants.lua`
- `Utils.lua`

### Шаг 3: Создать папку Services в ServerScriptService

1. Щелкните правой кнопкой на **ServerScriptService** → Insert Object → Folder
2. Назовите папку **Services**
3. Скопируйте туда:

**Из папки src/Server/Services/**
- `NetworkHandler.lua`

### Шаг 4: Добавить главный серверный скрипт

1. Щелкните правой кнопкой на **ServerScriptService** → Insert Object → Script
2. Назовите его **Main**
3. Замените содержимое на содержимое `src/Server/Main.lua`

### Шаг 5: Добавить главный клиентский скрипт

1. Щелкните правой кнопкой на **StarterPlayer** → Insert Object → Folder
2. Назовите папку **StarterPlayerScripts** (если ее нет)
3. Щелкните правой кнопкой на **StarterPlayerScripts** → Insert Object → LocalScript
4. Назовите его **Main**
5. Замените содержимое на содержимое `src/Client/Main.lua`

## 🎮 Основные системы

### Серверная часть (ServerScriptService)

#### **TerritoryManager** - управление территориями
```lua
TerritoryManager:Initialize()
TerritoryManager:GetTerritory(id)
TerritoryManager:GetNeighbors(territory)
TerritoryManager:SetOwner(territoryId, newOwner)
TerritoryManager:CanAttack(sourceId, targetId)
```

#### **ResourceManager** - система ресурсов
```lua
ResourceManager:InitializePlayer(playerId)
ResourceManager:GetResources(playerId)
ResourceManager:AddResource(playerId, resourceName, amount)
ResourceManager:SpendResources(playerId, costTable)
ResourceManager:GenerateResourcesFromTerritories(territoriesManager)
```

#### **CombatSystem** - боевая механика
```lua
CombatSystem:AttackTerritory(attacker, sourceTerrId, targetTerrId, troops, territoryMgr, resourceMgr)
CombatSystem:CalculateAttackPower(territory, troops)
CombatSystem:CalculateDefensePower(territory)
```

#### **BuildingSystem** - постройки
```lua
BuildingSystem:ConstructBuilding(owner, territoryId, buildingType, resourceMgr)
BuildingSystem:GetBuildingsByTerritory(territoryId)
BuildingSystem:UpgradeBuilding(buildingId, resourceMgr)
```

#### **GameManager** - игровой цикл
```lua
GameManager:StartGame()
GameManager:AddPlayer(playerId, playerName)
GameManager:GetTimeRemaining()
```

### Клиентская часть (StarterPlayer > StarterPlayerScripts)

#### **TopBar** - верхняя панель ресурсов
- 📊 Отображение 6 ресурсов
- ⏱️ Таймер игры
- ⚙️ Кнопка настроек

#### **MapController** - визуали��ация карты
- 🗺️ Сетка 16x12 регионов
- 🎨 Цветная визуализация
- 🖱️ Система выбора территорий

#### **TerritoryInfoPanel** - информация о территории
- 📍 Данные выбранной территории
- 📦 Ресурсы региона
- 🪖 Количество войск

#### **BuildMenu** - меню построек
- 🏗️ Список всех зданий
- 💰 Стоимость и требования
- 📊 Категоризация

#### **Leaderboard** - таблица лидеров
- 🏆 Топ игроков
- 📊 Ранжирование

## 🎯 Ресурсы игры

### 6 Типов ресурсов:
1. **Войска** (Troops) - основная армия
2. **Золото** (Money) - валюта
3. **Бетон** (Concrete) - строительный материал
4. **Сталь** (Steel) - продвинутый материал
5. **Топливо** (Fuel) - для техники
6. **Уран** (Uranium) - редкий ресурс

## 🏗️ Типы зданий

### Экономические:
- **Ферма** - +2 золота/сек
- **Карьер** - +3 бетона/сек
- **Стальной завод** - +2 стали/сек
- **Нефтеперерабатывающий завод** - +2.5 топлива/сек
- **Завод обогащения** - +0.5 урана/сек

### Военные:
- **Пост обороны** - +5% урона
- **Порт** - корабли + развертывание
- **Ракетная установка** - ядерное оружие

### Инфраструктура:
- **Банк** - +8 золота/тик
- **Фабрика** - 1.5x скорость

## ⌨️ Управление

| Клавиша | Действие |
|---------|----------|
| L | Показать/скрыть таблицу лидеров |
| B | Показать/скрыть меню построек |
| ESC | Закрыть все панели |
| Click | Выбрать территорию |

## 🔌 Сетевые события

### Remote Events (создаются автоматически в ReplicatedStorage):
- **AttackTerritory** - атака на территорию
- **BuildStructure** - постройка здания
- **SyncResources** - синхронизация ресурсов
- **GameEvent** - игровое событие
- **PlayerAction** - действие игрока

## 📊 Баланс игры

### Начальные ресурсы:
```lua
Troops = 100
Money = 500
Concrete = 50
Steel = 25
Fuel = 30
Uranium = 5
```

### Боевая система:
```lua
Attack Power = 1.0 + (Troops/100) * 0.5
Defense Power = 1.5 + DefenseBuildings * 0.05 + DefendingTroops * 0.3
```

## 🚀 Запуск игры

1. Откройте Roblox Studio
2. Следуйте инструкциям по установке выше
3. Нажмите **Play** (F5) для локального тестирования
4. Или нажмите **Run** для мультиплеера на локальной машине
5. Используйте клавиши для управления интерфейсом

## 📚 Документация

- `docs/DESIGN.md` - дизайн документ
- `docs/MECHANICS.md` - игровые механики
- `docs/API.md` - API справочник

## 🐛 Требования

- Roblox Studio (последняя версия)
- Lua 5.1+

## 👨‍💻 Разработчик

lodrol132 - 2026

## 📝 Лицензия

MIT
