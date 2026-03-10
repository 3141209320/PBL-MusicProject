// entry/src/main/ets/pages/Index.ets
import { TabType } from '../models/Index';
import { SAFE_TOP, SAFE_BOTTOM } from '../constants/index';
import Recommend from '../views/Recommend';
import Find from '../views/Find';
import Moment from '../views/Moment';
import Mine from '../views/Mine';

@Entry
@Component
struct Index {
  // 1. 状态变量：记录当前选中的页签 name
  @State isActive: string = 'recommend';

  // 2. 读取全局存储的安全距离
  @StorageProp(SAFE_TOP) safeTop: number = 0;
  @StorageProp(SAFE_BOTTOM) safeBottom: number = 0;

  // 3. 定义页签数据
  tabData: TabType[] = [
    { icon: $r('app.media.ic_recommend'), text: '推荐', name: 'recommend' },
    { icon: $r('app.media.ic_find'), text: '发现', name: 'find' },
    { icon: $r('app.media.ic_moment'), text: '动态', name: 'moment' },
    { icon: $r('app.media.ic_mine'), text: '我的', name: 'mine' }
  ];

  // 4. 自定义页签构建器 (图标 + 文字)
  @Builder
  tabBarBuilder(item: TabType) {
    Column({ space: 5 }) {
      Image(item.icon)
        .height(24)
        .width(24)
        // 动态颜色：选中为粉色，未选中为青色
        .fillColor(this.isActive == item.name ? '#e4608b' : '#6da8a5')

      Text(item.text)
        .fontSize(14)
        // 动态颜色
        .fontColor(this.isActive == item.name ? '#e4608b' : '#6da8a5')
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .width('100%') // 确保点击区域占满
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End }) {
        ForEach(this.tabData, (item: TabType) => {
          TabContent() {
            // 5. 根据 name 渲染不同的子组件
            if (item.name == 'recommend') {
              Recommend()
            } else if (item.name == 'find') {
              Find()
            } else if (item.name == 'moment') {
              Moment()
            } else if (item.name == 'mine') {
              Mine()
            }
          }
          .backgroundColor('#131215')
          .tabBar(this.tabBarBuilder(item)) // 使用自定义页签
        })
      }
      .backgroundColor('#3b3f42')
      // 6. 监听切换事件，更新高亮状态
      .onChange((index: number) => {
        this.isActive = this.tabData[index].name;
      })
      // 7. 设置底部安全内边距，防止被导航条遮挡
      .padding({ bottom: this.safeBottom })
    }
    .width('100%')
    .height('100%')
  }
}