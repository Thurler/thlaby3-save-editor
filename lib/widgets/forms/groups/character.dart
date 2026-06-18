import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tfields/forms.dart';
import 'package:thlaby3_save_editor/save.dart';
import 'package:thlaby3_save_editor/save/character.dart';
import 'package:thlaby3_save_editor/save/enums/character.dart';
import 'package:thlaby3_save_editor/save/levelbonus.dart';
import 'package:thlaby3_save_editor/save/library.dart';
import 'package:thlaby3_save_editor/save/shrine_item.dart';
import 'package:thlaby3_save_editor/save/skill_tree.dart';
import 'package:thlaby3_save_editor/widgets/forms/groups/character_basic.dart';
import 'package:thlaby3_save_editor/widgets/forms/groups/character_level_bonus.dart';
import 'package:thlaby3_save_editor/widgets/forms/groups/character_library.dart';
import 'package:thlaby3_save_editor/widgets/forms/groups/character_shrine_items.dart';
import 'package:thlaby3_save_editor/widgets/forms/groups/character_skill_points.dart';

/// An enumeration of the subforms we want in our character data form
enum CharacterFormField
    implements TFormField, TFormSubgroup<CharacterFormField> {
  basic('Level, EXP, BP', initiallyExpanded: true),
  library('Library points'),
  levelBonus('Level up bonuses'),
  skillPoints('Unused skill points'),
  uniqueSkills('Learned skills (Unique)'),
  trainingSkills('Learned skills (Training)'),
  shrineItems('Shrine items'),
  equipment('Equipment');

  @override
  final String title;

  const CharacterFormField(this.title, {this.initiallyExpanded = false});

  @override
  List<CharacterFormField> get fields => <CharacterFormField>[this];

  @override
  final bool initiallyExpanded;
}

/// The actual form that holds all the subforms of a character's data structures
class CharacterForm extends TFormGroup<CharacterData, void, CharacterFormField>
    with
        TSubgroups<CharacterData, void, CharacterFormField,
            CharacterFormField> {
  /// The data used to initialize the form. This is kept to ensure a fallback on
  /// null values
  final CharacterData initialData;

  // Initialize the form keys by hand since we'll add subforms through the
  // generic form add

  final CharacterBasicFormKey _basicFormKey = CharacterBasicFormKey();

  final CharacterLibraryFormKey _libraryFormKey = CharacterLibraryFormKey();

  final CharacterLevelBonusFormKey _levelBonusFormKey =
      CharacterLevelBonusFormKey();

  final CharacterSkillPointsFormKey _skillPointsFormKey =
      CharacterSkillPointsFormKey();

  //final CharacterSkillLevelFormKey _uniqueSkillsFormKey =
  //    CharacterSkillLevelFormKey();

  //final CharacterSkillLevelFormKey _trainingSkillsFormKey =
  //    CharacterSkillLevelFormKey();

  final CharacterShrineItemsFormKey _shrineItemsFormKey =
      CharacterShrineItemsFormKey();

  //final CharacterEquipFormKey _equipFormKey = CharacterEquipFormKey();

  CharacterForm({
    required SaveFile saveFile,
    required Character character,
    required super.enabled,
    required GroupSetState? setState,
  }) :
    initialData = saveFile.characterData[character.index],
    super(setState: setState) {
    addGenericForm(
      formName: CharacterFormField.basic,
      key: _basicFormKey,
      form: CharacterBasicForm(
        key: _basicFormKey,
        initialValue: CharacterBasic.fromCharacterData(initialData),
        // Whenever the current level changes, we must re-validate the learned
        // unique skills
        onLevelChange: _onCurrentLevelChange,
        // Whenever the max level changes, we must update how many unique skill
        // points are available to be spent
        onMaxLevelChange: (_) => _onUniqueLevelChange(),
        // Whenever the battle point count changes, we must update how many
        // training skill points are available to be spent
        onBattlePointsChange: (_) => _onTrainingLevelChange(),
        enabled: enabled,
        setState: setState,
      ),
    );

    addGenericForm(
      formName: CharacterFormField.library,
      key: _libraryFormKey,
      form: CharacterLibraryForm(
        key: _libraryFormKey,
        initialValue: initialData.libraryLevels,
        enabled: enabled,
        setState: setState,
      ),
    );

    addGenericForm(
      formName: CharacterFormField.levelBonus,
      key: _levelBonusFormKey,
      form: CharacterLevelBonusForm(
        key: _levelBonusFormKey,
        initialValue: initialData.levelBonus,
        enabled: enabled,
        setState: setState,
      ),
    );

    addGenericForm(
      formName: CharacterFormField.skillPoints,
      key: _skillPointsFormKey,
      form: CharacterSkillPointsForm(
        key: _skillPointsFormKey,
        initialValue: (
          initialData.unusedUniqueSkillPoints,
          initialData.unusedTrainingSkillPoints,
        ),
        enabled: enabled,
        setState: setState,
      ),
    );

    //addGenericForm(
    //  formName: CharacterFormField.uniqueSkills,
    //  key: _uniqueSkillsFormKey,
    //  form: CharacterSkillLevelForm(
    //    key: _genericSkillsFormKey,
    //    initialValue: initialCommonSkillsValue,
    //    onLevelChange: (_) => _onSkillLevelChange(),
    //    dataOverrides: <Skill, ({bool? enabled, String? subtitle})>{
    //      for ((int, Skill) indexSkill in tomeSkills.indexed)
    //        indexSkill.$2: initialData.getCommonSkillLocked(indexSkill.$1)
    //        ? (enabled: false, subtitle: TomeData.lockedMessage)
    //        : (enabled: null, subtitle: null),
    //    },
    //    enabled: enabled,
    //    setState: setState,
    //  ),
    //);

    //addGenericForm(
    //  formName: CharacterFormField.trainingSkills,
    //  key: _trainingSkillsFormKey,
    //  form: CharacterSkillLevelForm(
    //    key: _personalSkillsFormKey,
    //    initialValue: initialPersonalSkillsValue,
    //    onLevelChange: (_) => _onSkillLevelChange(),
    //    enabled: enabled,
    //    setState: setState,
    //  ),
    //);

    addGenericForm(
      formName: CharacterFormField.shrineItems,
      key: _shrineItemsFormKey,
      form: CharacterShrineItemsForm(
        key: _shrineItemsFormKey,
        initialValue: initialData.shrineItems,
        enabled: enabled,
        setState: setState,
        // Whenever the skill book count changes, we must update how many unique
        // skill points are available to be spent
        onSkillCountChange: (_) => _onUniqueLevelChange(),
      ),
    );

    //addGenericForm(
    //  formName: CharacterFormField.equipment,
    //  key: _equipFormKey,
    //  form: CharacterEquipForm(
    //    key: _equipFormKey,
    //    initialValue: (initialData.mainEquip, initialData.subEquips),
    //    availableMainEquips: saveFile.mainInventoryData.where(
    //      (ItemSlot<MainEquip> slot) => slot.isUnlocked,
    //    ).map(
    //      (ItemSlot<MainEquip> slot) => slot.item,
    //    ).toList(),
    //    availableSubEquips: saveFile.subInventoryData.where(
    //      (ItemSlot<SubEquip> slot) => slot.isUnlocked,
    //    ).map(
    //      (ItemSlot<SubEquip> slot) => slot.item,
    //    ).toList(),
    //    unlockMainEquip: (MainEquip item) =>
    //        _fixLockedEquip(saveFile.mainInventoryData, item),
    //    unlockSubEquip: (SubEquip item) =>
    //        _fixLockedEquip(saveFile.subInventoryData, item),
    //    enabled: enabled,
    //    setState: setState,
    //  ),
    //);
  }

  void _onCurrentLevelChange(int? newLevel) {
    // We must cause a validation error on skill nodes above the current level
  }

  void _onUniqueLevelChange() {
    // Each character starts with 2 points, and then they get:
    // - 1 for each book of guidance
    // - 1 for each level 1-20
    // - 1 for each 2 levels 21-100
    // - 1 for each 5 levels 101-500
    // - 2 for each 10th level 1-100
    // - 1 for each 10th level 101-1000
    int level = basicData.maxLevel;
    int available = 2 + shrineItemData.skill + min(level, 20);
    if (level > 20) {
      available += (min(level, 100) - 20) ~/ 2;
    }
    if (level > 9) {
      available += 2 * (min(level, 100) ~/ 10);
    }
    if (level > 100) {
      available += (min(level, 500) - 100) ~/ 5;
      available += (min(level, 1000) - 100) ~/ 10;
    }
    // Subtract points for each skill learned based on its data
    for (SkillNode node in initialData.skills.uniqueSkillTree.skills) {
      if (node.isLearned) {
        available -= node.skill.cost;
      }
    }
    _skillPointsFormKey.currentState?.widget.group.unusedUnique = available;
  }

  void _onTrainingLevelChange() {
    // Available count is based solely on BP: 30, 30, 31, 31, 32, 32, ...
    int available = 0;
    int bpCount = basicData.battlePoints;
    int needed = 30;
    // Loop until BP runs out
    while (bpCount >= needed) {
      bpCount -= needed;
      available++;
      if (bpCount >= needed) {
        bpCount -= needed;
        available++;
      }
      needed += 1;
    }
    // Subtract points for each skill learned based on its data
    for (SkillNode node in initialData.skills.trainingSkillTree.skills) {
      if (node.isLearned) {
        available -= node.skill.cost;
      }
    }
    _skillPointsFormKey.currentState?.widget.group.unusedTraining = available;
  }

  //void _fixLockedEquip<I extends Item>(List<ItemSlot<I>> slots, I item) {
  //  ItemSlot<I> chosen =
  //      slots.firstWhere((ItemSlot<I> slot) => slot.item == item);
  //  chosen.isUnlocked = true;
  //}

  @override
  CharacterData makeEntity(void additionalData) => CharacterData(
    character: initialData.character,
    level: basicData.level,
    maxLevel: basicData.maxLevel,
    mainEquipLevel: initialData.mainEquipLevel,
    unusedUniqueSkillPoints: skillPointsData.$1,
    unusedTrainingSkillPoints: skillPointsData.$2,
    bp: basicData.battlePoints,
    experience: basicData.exp,
    libraryLevels: libraryData,
    levelBonus: levelBonusData,
    skills: initialData.skills,
    shrineItems: shrineItemData,
    mainEquips: initialData.mainEquips,
    subEquips: initialData.subEquips,
  );

  CharacterBasic get basicData =>
      _basicFormKey.currentState?.value ??
      CharacterBasic.fromCharacterData(initialData);

  LibraryData get libraryData =>
      _libraryFormKey.currentState?.value ?? initialData.libraryLevels;

  LevelBonus get levelBonusData =>
      _levelBonusFormKey.currentState?.value ?? initialData.levelBonus;

  (int, int) get skillPointsData =>
      _skillPointsFormKey.currentState?.value ?? (
    initialData.unusedUniqueSkillPoints,
    initialData.unusedTrainingSkillPoints,
  );

  //Map<Skill, int> get commonSkills =>
  //    _genericSkillsFormKey.currentState?.value ?? initialCommonSkillsValue;

  //Map<Skill, int> get personalSkills =>
  //   _personalSkillsFormKey.currentState?.value ?? initialPersonalSkillsValue;

  ShrineItemData get shrineItemData =>
      _shrineItemsFormKey.currentState?.value ?? initialData.shrineItems;

  //EquipTuple get equipData =>
  //    _equipFormKey.currentState?.value ?? (
  //  initialData.mainEquip,
  //  initialData.subEquips
  //);

  @override
  List<CharacterFormField> get subgroups => <CharacterFormField>[
    CharacterFormField.basic,
    CharacterFormField.library,
    CharacterFormField.levelBonus,
    CharacterFormField.skillPoints,
    CharacterFormField.shrineItems,
  ];
}

class CharacterFormWidget
    extends TFormSubgroupListWidget<CharacterFormField, CharacterForm> {
  const CharacterFormWidget({required super.form, super.key}) :
    super.noSubmit();

  @override
  List<Widget> buildSubgroup(
    CharacterFormField subgroup,
    BuildContext context,
  ) {
    return <Widget>[form[subgroup]];
  }
}
