// @Entry
// @Component
// struct Start {
//   router = this.getUIContext().getRouter();
//   // 定时器 id
//   timerId: number = 0;
//   aboutToAppear(): void {
//     // 5秒后自动跳转到首页
//     this.timerId = setTimeout(() => {
//       this.router.replaceUrl({ url: 'pages/Index' });
//     }, 5000);
//   }
//   aboutToDisappear() {
//     // 清除定时器
//     clearTimeout(this.timerId);
//   }
//   build() {
//     Stack({ alignContent: Alignment.TopEnd }) {
//       Image($r('app.media.ad'))
//       Button('跳过')
//         .margin(10)
//         .backgroundColor('#4d000000')
//         .onClick(() => {
//           this.router.replaceUrl({ url: 'pages/Index' });
//         })
//     }
//   }
// }
// entry/src/main/ets/pages/Start.ets
import { SAFE_TOP } from '../constants/index';
// [关键修改] 从 @ohos.router 导入，而不是 @kit.ArkUI
import router from '@ohos.router';

@Entry
@Component
struct Start {
  @StorageProp(SAFE_TOP) safeTop: number = 0;
  timerId: number = 0;

  aboutToAppear(): void {
    this.timerId = setTimeout(() => {
      // 直接使用导入的 router 对象调用 replaceUrl
      router.replaceUrl({ url: 'pages/Index' });
    }, 5000);
  }

  aboutToDisappear(): void {
    if (this.timerId) {
      clearTimeout(this.timerId);
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Image($r('app.media.ad'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)

      Button('跳过')
        .margin({ top: this.safeTop + 10, right: 10 })
        .backgroundColor('#4d000000')
        .fontColor('#ffffff')
        .borderRadius(16)
        .padding({ left: 12, right: 12, top: 6, bottom: 6 })
        .onClick(() => {
          // 这里也使用导入的 router
          router.replaceUrl({ url: 'pages/Index' });
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }
}