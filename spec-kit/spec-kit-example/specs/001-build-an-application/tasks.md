# Tasks: Photo Album Organizer Application

**Input**: Design documents from `/specs/001-build-an-application/`
**Prerequisites**: plan.md (required), research.md

## Execution Flow (main)
```
1. Load plan.md from feature directory
2. Load optional design documents: research.md
3. Generate tasks by category: Setup, Tests, Core, Integration, Polish
4. Apply task rules: [P] for parallel, sequential otherwise, TDD順守
5. Number tasks sequentially (T001, T002...)
6. Generate dependency graph
7. Create parallel execution examples
8. Validate task completeness
9. Return: SUCCESS (tasks ready for execution)
```

## Phase 3.1: Setup
- [ ] T001 Create project structure in `src/`, `tests/` per plan.md
- [ ] T002 Initialize Vite project with vanilla JS/HTML/CSS in `src/`
- [ ] T003 [P] Configure ESLint, Prettier, and EditorConfig for code quality
- [ ] T004 [P] Set up SQLite database file and schema for albums/photos metadata (local only)

## Phase 3.2: Tests First (TDD)
- [ ] T005 [P] Write integration test: create album, add photos, reorder albums, view tiles (in `tests/integration/test_album_flow.js`)
- [ ] T006 [P] Write contract test: album creation and duplicate date handling (in `tests/contract/test_album_contract.js`)
- [ ] T007 [P] Write contract test: photo tile preview and duplicate photo handling (in `tests/contract/test_photo_contract.js`)

## Phase 3.3: Core Implementation
- [ ] T008 [P] Implement Album model in `src/models/album.js`
- [ ] T009 [P] Implement Photo model in `src/models/photo.js`
- [ ] T010 Implement album service (create, reorder, prevent nesting) in `src/services/albumService.js`
- [ ] T011 Implement photo service (add, preview, deduplication) in `src/services/photoService.js`
- [ ] T012 Implement drag-and-drop UI for albums in `src/ui/AlbumList.js`
- [ ] T013 Implement tile preview UI for photos in `src/ui/PhotoTiles.js`
- [ ] T014 Implement SQLite access layer in `src/lib/sqlite.js`

## Phase 3.4: Integration
- [ ] T015 Integrate album/photo services with SQLite access layer
- [ ] T016 Integrate UI with services for full user flow
- [ ] T017 Implement error handling and user feedback in UI
- [ ] T018 Implement logging (console-based) for key actions

## Phase 3.5: Polish
- [ ] T019 [P] Write unit tests for album and photo models in `tests/unit/test_models.js`
- [ ] T020 [P] Write unit tests for services in `tests/unit/test_services.js`
- [ ] T021 [P] Write performance test for album/photo loading in `tests/unit/test_performance.js`
- [ ] T022 [P] Update project documentation in `README.md`
- [ ] T023 Manual test: follow quickstart and validate all user scenarios

## Dependencies
- Setup (T001-T004) → Tests (T005-T007) → Core (T008-T014) → Integration (T015-T018) → Polish (T019-T023)
- [P] tasks can run in parallel if in different files
- Tests must be written and fail before implementation

## Parallel Example
```
# Launch T003, T004 together:
Task: "Configure ESLint, Prettier, and EditorConfig for code quality"
Task: "Set up SQLite database file and schema for albums/photos metadata"

# Launch T005-T007 together:
Task: "Write integration test: create album, add photos, reorder albums, view tiles"
Task: "Write contract test: album creation and duplicate date handling"
Task: "Write contract test: photo tile preview and duplicate photo handling"

# Launch T008, T009 together:
Task: "Implement Album model"
Task: "Implement Photo model"
```

## Notes
- [P] tasks = different files, no dependencies
- Verify tests fail before implementing
- Commit after each task
- Avoid: vague tasks, same file conflicts

---
*Immediately executable. Each task specifiesファイルパスと依存関係を明記。*
