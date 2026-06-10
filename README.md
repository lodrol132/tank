# Territorial.io - Roblox Strategy Game

## Описание проекта
Многопользовательская стратегия захвата территорий с картой мира, разделенной на регионы. Игроки захватывают территории, управляют ресурсами и строят здания.

## Структура проекта

```
territorial-io/
├── src/
│   ├── Server/
│   │   ├── Managers/
│   │   │   ├── TerritoryManager.lua
│   │   │   ├── ResourceManager.lua
│   │   │   ├── CombatSystem.lua
│   │   │   ├── BuildingSystem.lua
│   │   │   └── GameManager.lua
│   │   ├── Services/
│   │   │   ├── NetworkHandler.lua
│   │   │   ├── DataStoreService.lua
│   │   │   └── EventManager.lua
│   │   └── Main.lua
│   ├── Client/
│   │   ├── UI/
│   │   │   ├── TopBar.lua
│   │   │   ├── TerritoryInfoPanel.lua
│   │   │   ├── BuildMenu.lua
│   │   │   └── Leaderboard.lua
│   │   ├── Controllers/
│   │   │   ├── MapController.lua
│   │   │   ├── InputController.lua
│   │   │   └── CameraController.lua
│   │   └── Main.lua
│   ├── Shared/
│   │   ├── Config.lua
│   │   ├── Constants.lua
│   │   ├── Utils.lua
│   │   └── Types.lua
│   └── Assets/
│       ├── Models/
│       ├── Sounds/
│       └── Particles/
├── docs/
│   ├── DESIGN.md
│   ├── API.md
│   └── MECHANICS.md
└── tests/
    └── test_suite.lua
```

## Основные системы

### 1. Территориальная система (TerritoryManager)
- Управление всеми территориями на карте
- Система смены владельцев
- Визуализация границ и цветов
- Система соседей для захвата

### 2. Система ресурсов (ResourceManager)
- 6 типов ресурсов: Войска, Золото, Бетон, Сталь, Топливо, Уран
- Генерация ресурсов каждую секунду
- Разные типы регионов дают разные ресурсы

### 3. Механика боя (CombatSystem)
- Расчет Attack Power vs Defense Power
- Прогресс захвата территории
- Система потери войск

### 4. Система построек (BuildingSystem)
- Экономические здания
- Военные здания
- Инфраструктура
- Апгрейды и производство

### 5. Сетевая синхронизация (NetworkHandler)
- RemoteEvents для действий
- Server-authoritative модель
- Anti-cheat механизмы

## Установка

1. Клонируй репозиторий
2. Открой Roblox Studio
3. Скопируй файлы в ServerScriptService, StarterPlayer и StarterGui
4. Настрой конфиг в `Config.lua`
5. Запусти игру

## Требования

- Roblox Studio (последняя версия)
- Lua 5.1+
- Roblox API

## Разработчик

lodrol132 - 2026
