//
//  ExtensionTests.swift
//  TWTaskPageTests
//
//  Created by Beibei Zhu on 2021/9/24.
//

import XCTest
@testable import TWTaskPage

class ExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDictionaryExtension() {
        let response: [String: Any] = ["success":true,
                        "data":[
                            ["id":"6108bbc2a5d29d175c2d4208",
                             "author_id":"51f0f267f4963ade0e08f503",
                             "tab":"share",
                             "content":"<div class=\"markdown-text\"><p>BFF、SSR、Serverless…… 随着技术的浪潮不断翻涌， Node.js 正在为我们逐渐带来更多的生产力。为了更好的了解 Node.js 生态现状，帮助大家：</p>\n<ul>\n<li>了解大家都是如何使用 Node.js？</li>\n<li>梳理这个语言的技术栈</li>\n<li>聚焦大家都在关注些什么？</li>\n<li>帮助开发者找准这个语言的定位（用来干什么的）</li>\n<li>找到目前生态所缺乏的以及被期望的内容</li>\n<li>辅助企业招聘</li>\n</ul>\n<p>欢迎您来参加 Node.js 开发者调查问卷，希望您能抽出一点时间，将您的感受和建议告诉我们，我们非常重视每位开发者的宝贵意见。</p>\n<p>问卷结束后我们会给留邮箱的同学第一时间电邮分析报告，期待您的参与！</p>\n<p>这大约需要花费您 3~5 分钟，链接请戳：<a href=\"https://www.wjx.cn/vj/Q08EYUi.aspx\">https://www.wjx.cn/vj/Q08EYUi.aspx</a></p>\n<p>钉钉/微信等 app 扫码也可以进入问卷\n<img src=\"//static.cnodejs.org/FvONO4yEIfK-iF1mDbZlskoiiYY2\" alt=\"qrcode_www.wjx.cn.png\"></p>\n<p>本问卷目前由腾讯 &amp; 阿里前端发起，去年的问卷 <a href=\"https://nodersurvey.github.io/reporters/\">https://nodersurvey.github.io/reporters/</a></p>\n</div>",
                             "title":"2021 Node.js 开发者问卷调查",
                             "last_reply_at":"2021-09-22T07:01:59.488Z",
                             "good":false,
                             "top":true,
                             "reply_count":49,
                             "visit_count":18889,
                             "create_at":"2021-08-03T03:45:06.729Z",
                             "author":["loginname":"lellansin","avatar_url":"https://avatars.githubusercontent.com/u/2081487?v=4&s=120"]
                            ]
                        ]
        ]
        
        let model = response.object() as ResponseModel?
        guard let modelTemp = model, let models = modelTemp.data else {
            return
        }
        let item = models[0]
        XCTAssertEqual(item.id, "6108bbc2a5d29d175c2d4208")
        XCTAssertEqual(item.authorId, "51f0f267f4963ade0e08f503")
        XCTAssertEqual(item.title, "2021 Node.js 开发者问卷调查")
        XCTAssertFalse(item.good!)
        XCTAssertTrue(item.top!)
        XCTAssertEqual(item.replyCount, 49)
        
        guard let author = item.author else {
            return
        }
        XCTAssertEqual(author.loginname, "lellansin")
        
        
    }

}
