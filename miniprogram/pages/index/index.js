const FORTUNES = [
  {
    level: "上上签",
    title: "春风得意",
    message: "今天的你自带好气场，适合主动表达，也适合把搁置的计划重新启动。",
    hint: "宜：行动、见面、分享"
  },
  {
    level: "上签",
    title: "渐入佳境",
    message: "答案不会一下出现，但你正在靠近它。保持现在的节奏，好事会慢慢显形。",
    hint: "宜：专注、整理、耐心"
  },
  {
    level: "中上签",
    title: "所念有应",
    message: "一个被你惦记许久的小愿望，今天可能收到温柔回应，记得留意身边的消息。",
    hint: "宜：联络、倾听、期待"
  },
  {
    level: "中签",
    title: "静待花开",
    message: "不必急着赶路，先照顾好自己的感受。稳定下来以后，方向自然会更清楚。",
    hint: "宜：休息、散步、复盘"
  },
  {
    level: "小吉",
    title: "偶遇微光",
    message: "平常的一天里藏着一点小惊喜，可能是一句好话，也可能是一次刚好的相遇。",
    hint: "宜：出门、微笑、记录"
  },
  {
    level: "吉",
    title: "顺水行舟",
    message: "今天适合借力而行，不必独自扛下所有事情。接受帮助，也是一种智慧。",
    hint: "宜：协作、请教、推进"
  },
  {
    level: "中吉",
    title: "云开见月",
    message: "困扰你的事情正在出现转机。先放下旧判断，你会看到一个更轻松的解法。",
    hint: "宜：沟通、尝试、放下"
  },
  {
    level: "上签",
    title: "心想事成",
    message: "你认真对待的事情，也正在认真地向你走来。今天值得对自己多一点相信。",
    hint: "宜：许愿、开始、坚持"
  }
]

function getTodayLabel() {
  const now = new Date()
  const weekdays = ["日", "一", "二", "三", "四", "五", "六"]
  return `${now.getMonth() + 1}月${now.getDate()}日 · 周${weekdays[now.getDay()]}`
}

function getTodayKey() {
  const now = new Date()
  return `${now.getFullYear()}-${now.getMonth() + 1}-${now.getDate()}`
}

Page({
  data: {
    navHeight: 88,
    dateLabel: "",
    drawCount: 0,
    isDrawing: false,
    showResult: false,
    result: FORTUNES[0]
  },

  onLoad() {
    this.setNavigationHeight()
    this.loadTodayStats()
  },

  onUnload() {
    if (this.drawTimer) {
      clearTimeout(this.drawTimer)
    }
    if (this.redrawTimer) {
      clearTimeout(this.redrawTimer)
    }
  },

  setNavigationHeight() {
    try {
      const windowInfo = wx.getWindowInfo()
      const menuButton = wx.getMenuButtonBoundingClientRect()
      const navHeight = menuButton.bottom + Math.max(menuButton.top - windowInfo.statusBarHeight, 8)
      this.setData({ navHeight })
    } catch (error) {
      this.setData({ navHeight: 88 })
    }
  },

  loadTodayStats() {
    const today = getTodayKey()
    const stats = wx.getStorageSync("fortuneDrawStats")
    const drawCount = stats && stats.date === today ? stats.count : 0

    this.setData({
      dateLabel: getTodayLabel(),
      drawCount
    })
  },

  drawFortune() {
    if (this.data.isDrawing || this.data.showResult) {
      return
    }

    this.setData({ isDrawing: true })
    wx.vibrateShort({
      type: "light",
      fail() {}
    })

    this.drawTimer = setTimeout(() => {
      const result = FORTUNES[Math.floor(Math.random() * FORTUNES.length)]
      const drawCount = this.data.drawCount + 1

      this.setData({
        isDrawing: false,
        showResult: true,
        result,
        drawCount
      })

      wx.setStorageSync("fortuneDrawStats", {
        date: getTodayKey(),
        count: drawCount
      })
    }, 1300)
  },

  closeResult() {
    this.setData({ showResult: false })
  },

  drawAgain() {
    this.setData({ showResult: false })
    this.redrawTimer = setTimeout(() => {
      this.drawFortune()
    }, 260)
  },

  stopTouch() {},

  onShareAppMessage() {
    return {
      title: "来抽一支属于你的今日签",
      path: "/pages/index/index"
    }
  }
})
