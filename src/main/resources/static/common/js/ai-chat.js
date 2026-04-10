/**
 * ============================================================
 * 咖咖小助手 - AI 聊天组件 JavaScript
 * ============================================================
 * 
 * 【功能说明】
 * 实现全局悬浮的 AI 聊天助手功能，包括：
 * 1. 悬浮按钮 (FAB) 和弹窗 UI
 * 2. 发送消息和显示 AI 回复
 * 3. 聊天历史记录的加载和清空
 * 4. 多 AI 提供商切换（DeepSeek/Gemini）
 * 
 * 【技术栈】
 * - jQuery（DOM 操作、AJAX 请求、事件绑定）
 * - ES6 模板字符串（动态生成 HTML）
 * 
 * 【文件位置】
 * static/common/js/ai-chat.js
 * 
 * 【依赖】
 * - jQuery 3.x
 * - Font Awesome（发送按钮图标）
 * - ai-chat.css（样式文件）
 * 
 */

// ============================================================
// 初始化入口
// ============================================================

/**
 * 页面加载完成后初始化 AI 聊天组件
 * 
 * $(document).ready() 是 jQuery 的标准写法
 * 确保 DOM 完全加载后再执行代码
 */
$(document).ready(function () {
    initAiChatWidget();
});

/**
 * 初始化 AI 聊天组件
 * 
 * 初始化流程：
 * 1. 创建 DOM 元素（悬浮按钮、弹窗）
 * 2. 绑定事件（点击、键盘）
 * 3. 加载历史记录（如果用户已登录）
 */
function initAiChatWidget() {
    createAiChatWidget();   // 步骤1：创建 UI
    bindAiChatEvents();     // 步骤2：绑定事件
    loadChatHistory();      // 步骤3：加载历史
}

// ============================================================
// UI 创建
// ============================================================

/**
 * 创建 AI 聊天组件的 DOM 结构
 * 
 * 【设计说明】
 * 使用 JavaScript 动态创建 DOM，而不是写在 HTML 中
 * 好处：只需在一个地方维护，所有页面自动生效
 * 
 * 【组件结构】
 * - 悬浮按钮 (FAB)：右下角的咖啡杯图标
 * - 聊天弹窗：包含头部、快捷按钮、消息区、输入框
 * - 遮罩层：移动端点击关闭用
 */
function createAiChatWidget() {
    // 使用 ES6 模板字符串构建 HTML
    var widgetHtml = `
        <!-- ===== 悬浮按钮 (Floating Action Button) ===== -->
        <!-- 固定在页面右下角，点击打开聊天窗口 -->
        <button class="ai-chat-fab" id="ai-chat-fab" title="咖咖小助手">
            <span class="fab-icon">☕</span>
            <span class="fab-badge" id="ai-fab-badge">1</span>
        </button>
        
        <!-- ===== 聊天弹窗 ===== -->
        <div class="ai-chat-popup" id="ai-chat-popup">
        
            <!-- 头部：标题、API 选择器、关闭按钮 -->
            <div class="ai-chat-header">
                <div class="avatar">☕</div>
                <div class="info">
                    <h4>咖咖小助手</h4>
                    <p>在线 · 随时为您服务</p>
                </div>
                <!-- AI 提供商选择器 -->
                <select id="ai-provider" class="ai-provider-select">
                    <option value="deepseek">DeepSeek</option>
                    <option value="gemini">Gemini</option>
                </select>
                <button class="close-btn" id="ai-chat-close" title="关闭">×</button>
            </div>
            
            <!-- 快捷问题按钮 -->
            <div class="ai-quick-actions">
                <button class="ai-quick-btn" data-question="推荐一款咖啡">推荐咖啡</button>
                <button class="ai-quick-btn" data-question="卡布奇诺什么味道">咖啡风味</button>
                <button class="ai-quick-btn" data-question="怎么冲泡咖啡">冲泡技巧</button>
                <!-- 清空历史按钮 -->
                <button class="ai-clear-btn" id="ai-clear-history" title="清空聊天记录">🗑️</button>
            </div>
            
            <!-- 消息显示区域 -->
            <div class="ai-chat-messages" id="ai-messages">
                <!-- 消息会动态添加到这里 -->
            </div>
            
            <!-- 输入区域 -->
            <div class="ai-chat-input">
                <input type="text" id="ai-input" placeholder="请输入您的问题..." autocomplete="off">
                <button id="ai-send-btn"><i class="fa fa-paper-plane"></i></button>
            </div>
        </div>
        
        <!-- ===== 遮罩层（移动端） ===== -->
        <!-- 点击遮罩层可关闭弹窗 -->
        <div class="ai-chat-overlay" id="ai-chat-overlay"></div>
    `;

    // 将 HTML 追加到 body 末尾
    $('body').append(widgetHtml);
}

// ============================================================
// 事件绑定
// ============================================================

/**
 * 绑定所有交互事件
 * 
 * 【事件委托说明】
 * 对于动态创建的元素，使用 $(document).on() 进行事件委托
 * 这样即使元素是后来创建的，事件也能正常触发
 */
function bindAiChatEvents() {
    // ----- 弹窗控制 -----

    // 悬浮按钮点击：打开/关闭聊天窗口
    $(document).on('click', '#ai-chat-fab', function () {
        toggleAiChat();
    });

    // 关闭按钮点击
    $(document).on('click', '#ai-chat-close', function () {
        closeAiChat();
    });

    // 遮罩层点击关闭（移动端友好）
    $(document).on('click', '#ai-chat-overlay', function () {
        closeAiChat();
    });

    // ----- 消息发送 -----

    // 发送按钮点击
    $(document).on('click', '#ai-send-btn', function () {
        sendAiMessage();
    });

    // 输入框回车发送
    $(document).on('keypress', '#ai-input', function (e) {
        if (e.which === 13) {  // 13 是回车键的 keyCode
            sendAiMessage();
        }
    });

    // ----- 快捷功能 -----

    // 快捷问题按钮点击
    $(document).on('click', '.ai-quick-btn', function () {
        var question = $(this).data('question');  // 从 data-question 属性获取问题
        $('#ai-input').val(question);              // 填入输入框
        sendAiMessage();                           // 自动发送
    });

    // 清空历史记录按钮
    $(document).on('click', '#ai-clear-history', function () {
        clearChatHistory();
    });

    // ----- 键盘快捷键 -----

    // ESC 键关闭弹窗
    $(document).on('keydown', function (e) {
        if (e.key === 'Escape') {
            closeAiChat();
        }
    });
}

// ============================================================
// 历史记录功能
// ============================================================

/**
 * 加载聊天历史记录
 * 
 * 【调用时机】
 * 页面加载时自动调用
 * 
 * 【逻辑说明】
 * 1. 向后端请求历史记录
 * 2. 如果有记录，显示历史消息
 * 3. 如果没有记录或未登录，显示欢迎消息
 */
function loadChatHistory() {
    $.ajax({
        url: 'ai/history',          // 请求历史记录接口
        method: 'GET',
        success: function (response) {
            if (response.success && response.history && response.history.length > 0) {
                // 有历史记录：清空现有内容，显示历史
                $('#ai-messages').empty();

                response.history.forEach(function (msg) {
                    // isHistory=true 表示是历史消息，不播放动画
                    appendAiMessage(msg.role, msg.content, true);
                });

                scrollToBottom();  // 滚动到最新消息
            } else {
                // 没有历史记录：显示欢迎消息
                addWelcomeMessage();
            }
        },
        error: function () {
            // 请求失败（可能未登录）：显示欢迎消息
            addWelcomeMessage();
        }
    });
}

/**
 * 添加欢迎消息
 * 
 * 当用户首次使用或没有历史记录时显示
 */
function addWelcomeMessage() {
    var messagesContainer = $('#ai-messages');
    // 确保只在容器为空时添加
    if (messagesContainer.children().length === 0) {
        appendAiMessage('ai', '你好！我是咖咖小助手 ☕ 有什么关于咖啡的问题可以问我哦~');
    }
}

/**
 * 清空聊天历史记录
 * 
 * 【流程】
 * 1. 弹出确认框
 * 2. 发送 DELETE 请求到后端
 * 3. 清空前端显示，添加欢迎消息
 */
function clearChatHistory() {
    // 确认对话框，防止误操作
    if (!confirm('确定要清空所有聊天记录吗？')) {
        return;
    }

    $.ajax({
        url: 'ai/history',
        method: 'DELETE',           // RESTful 风格：DELETE 方法表示删除
        success: function (response) {
            if (response.success) {
                $('#ai-messages').empty();   // 清空消息区域
                addWelcomeMessage();         // 添加欢迎消息
            } else {
                alert(response.message || '清空失败');
            }
        },
        error: function () {
            alert('清空失败，请稍后再试');
        }
    });
}

// ============================================================
// 弹窗控制
// ============================================================

/**
 * 切换聊天窗口显示状态
 * 
 * 通过添加/移除 CSS 类来控制显示
 * 动画效果在 CSS 中定义
 */
function toggleAiChat() {
    var popup = $('#ai-chat-popup');
    var fab = $('#ai-chat-fab');
    var overlay = $('#ai-chat-overlay');

    if (popup.hasClass('show')) {
        // 当前是打开状态，关闭它
        closeAiChat();
    } else {
        // 当前是关闭状态，打开它
        popup.addClass('show');      // 显示弹窗
        fab.addClass('active');       // 悬浮按钮变色
        overlay.addClass('show');     // 显示遮罩层（移动端）
        $('#ai-fab-badge').hide();   // 隐藏未读提示
        $('#ai-input').focus();       // 自动聚焦输入框
    }
}

/**
 * 关闭聊天窗口
 */
function closeAiChat() {
    $('#ai-chat-popup').removeClass('show');
    $('#ai-chat-fab').removeClass('active');
    $('#ai-chat-overlay').removeClass('show');
}

// ============================================================
// 消息发送与显示
// ============================================================

/**
 * 发送消息
 * 
 * 【完整流程】
 * 1. 获取输入框内容
 * 2. 显示用户消息（气泡）
 * 3. 显示"正在输入"动画
 * 4. 发送 AJAX 请求到后端
 * 5. 收到回复后显示 AI 消息
 */
function sendAiMessage() {
    var input = $('#ai-input');
    var message = input.val().trim();

    // 空消息不发送
    if (!message) {
        appendAiMessage('ai', '输入内容不能为空');
        return;
    }

    // 清空输入框，禁用输入（防止重复发送）
    input.val('');
    setAiInputEnabled(false);

    // 显示用户消息
    appendAiMessage('user', message);

    // 显示"正在输入"动画
    showTypingIndicator();

    // 获取选择的 AI 提供商
    var provider = $('#ai-provider').val() || 'deepseek';

    // 发送请求到后端
    $.ajax({
        url: 'ai/chat',             // 后端接口地址
        method: 'POST',
        data: {
            message: message,        // 用户消息
            provider: provider       // AI 提供商
        },
        success: function (response) {
            hideTypingIndicator();   // 隐藏输入动画
            if (response.success) {
                appendAiMessage('ai', response.reply);  // 显示 AI 回复
            } else {
                appendAiMessage('ai', response.reply || '抱歉，出现了一些问题 😅');
            }
            setAiInputEnabled(true);  // 恢复输入
        },
        error: function (xhr, status, error) {
            hideTypingIndicator();
            appendAiMessage('ai', '网络连接出现问题，请稍后再试 😅');
            setAiInputEnabled(true);
            console.error('AI Chat Error:', error);
        }
    });
}

/**
 * 添加消息到聊天区域
 * 
 * @param {string} type - 消息类型：'user'（用户）或 'ai'（AI助手）
 * @param {string} content - 消息内容
 * @param {boolean} isHistory - 是否为历史消息（历史消息不播放动画）
 */
function appendAiMessage(type, content, isHistory) {
    var messagesContainer = $('#ai-messages');

    // 处理消息内容中的换行符，转换为 HTML 换行
    var formattedContent = content.replace(/\n/g, '<br>');

    // 历史消息不添加动画类
    var animClass = isHistory ? '' : ' animated';

    // 构建消息 HTML
    // type 类会决定消息气泡的样式（用户靠右，AI 靠左）
    var messageHtml =
        '<div class="ai-message ' + type + animClass + '">' +
        '<div class="bubble">' + formattedContent + '</div>' +
        '</div>';

    messagesContainer.append(messageHtml);
    scrollToBottom();  // 滚动到最新消息
}

/**
 * 显示"正在输入"指示器
 * 
 * 三个跳动的点，模拟 AI 正在思考
 */
function showTypingIndicator() {
    var messagesContainer = $('#ai-messages');
    var typingHtml =
        '<div class="ai-message ai typing" id="typing-indicator">' +
        '<div class="bubble">' +
        '<span class="typing-dot"></span>' +
        '<span class="typing-dot"></span>' +
        '<span class="typing-dot"></span>' +
        '</div>' +
        '</div>';

    messagesContainer.append(typingHtml);
    scrollToBottom();
}

/**
 * 隐藏"正在输入"指示器
 */
function hideTypingIndicator() {
    $('#typing-indicator').remove();
}

// ============================================================
// 工具函数
// ============================================================

/**
 * 滚动消息区域到底部
 * 
 * 确保用户始终能看到最新的消息
 */
function scrollToBottom() {
    var messagesContainer = $('#ai-messages');
    messagesContainer.scrollTop(messagesContainer[0].scrollHeight);
}

/**
 * 设置输入框启用/禁用状态
 * 
 * 发送消息时禁用，防止重复发送
 * 收到回复后恢复
 * 
 * @param {boolean} enabled - true 启用，false 禁用
 */
function setAiInputEnabled(enabled) {
    $('#ai-input').prop('disabled', !enabled);
    $('#ai-send-btn').prop('disabled', !enabled);

    if (enabled) {
        $('#ai-input').focus();  // 恢复后自动聚焦
    }
}
