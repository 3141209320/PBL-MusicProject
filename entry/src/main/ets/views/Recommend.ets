import { SAFE_TOP } from '../constants/index';

@Component
export default struct Recommend {
  @StorageProp(SAFE_TOP) safeTop: number = 0;

  build() {
    Column() {
      Text('推荐内容')
        .fontColor('#fff')
        .fontSize(20)
    }
    .width('100%')
    .height('100%')
    .padding({ top: this.safeTop }) // 应用顶部安全距离
  }
}