import { SAFE_TOP, SAFE_BOTTOM } from '../constants/index';
import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';

const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    try {
      this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    } catch (err) {
      hilog.error(DOMAIN, 'testTag', 'Failed to set colorMode. Cause: %{public}s', JSON.stringify(err));
    }
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Start', (err) => { // 如果你的首页直接是Index，这里改为 'pages/Index'
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }

      // 1. 获取主窗口
      const mainWindow = windowStage.getMainWindowSync();

      // 2. 设置沉浸式全屏
      mainWindow.setWindowLayoutFullScreen(true);

      // 3. 设置状态栏文字颜色为白色
      mainWindow.setWindowSystemBarProperties({
        statusBarContentColor: '#ffffff'
      });

      // 4. 计算顶部安全区高度 (状态栏)
      const avoidArea = mainWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      const safeTop = mainWindow.getUIContext().px2vp(avoidArea.topRect.height);

      // 5. 存储顶部高度到全局
      AppStorage.setOrCreate(SAFE_TOP, safeTop);

      // 6. 计算底部安全区高度 (导航指示条)
      const navigationArea = mainWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
      const safeBottom = mainWindow.getUIContext().px2vp(navigationArea.bottomRect.height);

      // 7. 存储底部高度到全局
      AppStorage.setOrCreate(SAFE_BOTTOM, safeBottom);
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }
}