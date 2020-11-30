import "package:test/test.dart";

import "package:fast_immutable_collections/fast_immutable_collections.dart";

void main() {
  test("ConfigSet.isDeepEquals getter", () {
    expect(ConfigSet().isDeepEquals, isTrue);
    expect(ConfigSet(isDeepEquals: false).isDeepEquals, isFalse);
  });

  test("ConfigSet.sort getter", () {
    expect(ConfigSet().sort, isTrue);
    expect(ConfigSet(sort: false).sort, isFalse);
  });

  test("ConfigSet.== operator", () {
    const ConfigSet configSet1 = ConfigSet(),
        configSet2 = ConfigSet(isDeepEquals: false),
        configSet3 = ConfigSet(sort: false);
    final ConfigSet configSet4 = ConfigSet(),
        configSet5 = ConfigSet(isDeepEquals: false),
        configSet6 = ConfigSet(sort: false);

    expect(configSet1 == configSet1, isTrue);
    expect(configSet1 == configSet2, isFalse);
    expect(configSet1 == configSet3, isFalse);
    expect(configSet1 == configSet4, isTrue);
    expect(configSet1 == configSet5, isFalse);
    expect(configSet1 == configSet6, isFalse);

    expect(configSet2 == configSet1, isFalse);
    expect(configSet2 == configSet2, isTrue);
    expect(configSet2 == configSet3, isFalse);
    expect(configSet2 == configSet4, isFalse);
    expect(configSet2 == configSet5, isTrue);
    expect(configSet2 == configSet6, isFalse);

    expect(configSet3 == configSet1, isFalse);
    expect(configSet3 == configSet2, isFalse);
    expect(configSet3 == configSet3, isTrue);
    expect(configSet3 == configSet4, isFalse);
    expect(configSet3 == configSet5, isFalse);
    expect(configSet3 == configSet6, isTrue);
  });

  test("ConfigSet.copyWith()", () {
    const ConfigSet configSet1 = ConfigSet();
    final ConfigSet configSetIdentical = configSet1.copyWith(),
        configSet1WithDeepFalse = configSet1.copyWith(isDeepEquals: false),
        configSet1WithSortFalse = configSet1.copyWith(sort: false),
        configSet1WithDeepAndSortFalse = configSet1.copyWith(isDeepEquals: false, sort: false);

    expect(identical(configSet1, configSetIdentical), isTrue);

    expect(identical(configSet1, configSet1WithDeepFalse), isFalse);
    expect(configSet1.isDeepEquals, !configSet1WithDeepFalse.isDeepEquals);
    expect(configSet1.sort, configSet1WithDeepFalse.sort);

    expect(identical(configSet1, configSet1WithSortFalse), isFalse);
    expect(configSet1.isDeepEquals, configSet1WithSortFalse.isDeepEquals);
    expect(configSet1.sort, !configSet1WithSortFalse.sort);

    expect(identical(configSet1, configSet1WithDeepAndSortFalse), isFalse);
    expect(configSet1.isDeepEquals, !configSet1WithDeepAndSortFalse.isDeepEquals);
    expect(configSet1.sort, !configSet1WithDeepAndSortFalse.sort);
  });

  test("ConfigSet.hashCode getter", () {
    const ConfigSet configSet1 = ConfigSet(),
        configSet2 = ConfigSet(isDeepEquals: false),
        configSet3 = ConfigSet(sort: false);

    expect(configSet1.hashCode, ConfigSet().hashCode);
    expect(configSet2.hashCode, ConfigSet(isDeepEquals: false).hashCode);
    expect(configSet3.hashCode, ConfigSet(sort: false).hashCode);
    expect(configSet1.hashCode, isNot(configSet2.hashCode));
    expect(configSet1.hashCode, isNot(configSet3.hashCode));
    expect(configSet2.hashCode, isNot(configSet3.hashCode));
  });

  test("ConfigSet.toString()", () {
    expect(ConfigSet().toString(), "ConfigSet{isDeepEquals: true, sort: true, cacheHashCode: true}");
    expect(ConfigSet(isDeepEquals: false).toString(), "ConfigSet{isDeepEquals: false, sort: true, cacheHashCode: true}");
    expect(ConfigSet(sort: false).toString(), "ConfigSet{isDeepEquals: true, sort: false, cacheHashCode: true}");
  });

  test("defaultConfig | Is initially a ConfigSet with isDeepEquals = true and sort = true", () {
    expect(ISet.defaultConfig, const ConfigSet());
    expect(ISet.defaultConfig.isDeepEquals, isTrue);
    expect(ISet.defaultConfig.sort, isTrue);
  });

  test("defaultConfig | Can modify the default", () {
    ISet.defaultConfig = ConfigSet(isDeepEquals: false, sort: false);
    expect(ISet.defaultConfig, const ConfigSet(isDeepEquals: false, sort: false));
  });

  test("defaultConfig | Changing the default ConfigSet will throw an exception if lockConfig", () {
    ImmutableCollection.lockConfig();
    expect(() => ISet.defaultConfig = ConfigSet(isDeepEquals: false), throwsStateError);
  });
}
