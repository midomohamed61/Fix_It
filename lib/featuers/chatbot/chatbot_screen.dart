import 'package:flutter/material.dart';
import 'package:fix_it/core/themes/app_colors.dart';
import 'package:fix_it/featuers/BottomNavBar.dart';
import 'package:fix_it/featuers/home/HomeScreen.dart';
import 'package:fix_it/featuers/city/CityScreen.dart';
import 'package:fix_it/featuers/order/order_screen.dart';
import 'package:fix_it/featuers/profile/my_profile.dart';
import 'package:fix_it/featuers/payment/payment_method_screen.dart';
import 'package:fix_it/featuers/order/paid_orders.dart';
import 'package:fix_it/featuers/order/unpaid_orders.dart';
import 'package:fix_it/featuers/order/schedule_orders.dart';
import 'package:fix_it/featuers/profile/notification_screen.dart';
import 'package:fix_it/featuers/profile/help_support_screen.dart';
import 'package:fix_it/featuers/feedback/feedback_screen.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class ChatbotScreen extends StatefulWidget {
  final Function(int)? onTabChanged;
  
  const ChatbotScreen({super.key, this.onTabChanged});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addBotMessage("مرحباً! أنا المساعد الذكي لتطبيق Fix it. كيف يمكنني مساعدتك اليوم؟\n\nيمكنني مساعدتك في:\n• العثور على الخدمات\n• التنقل بين الصفحات\n• معلومات عن التطبيق\n• المساعدة والدعم");
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });
    _scrollToBottom();
  }

  void _addUserMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleSendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    _addUserMessage(message);
    _messageController.clear();

    // Process the message and generate response
    _processMessage(message);
  }

  void _processMessage(String message) {
    final lowerMessage = message.toLowerCase();
    
    // Simulate typing delay
    Future.delayed(const Duration(milliseconds: 500), () {
      String response = "";
      
      // Check for greetings in Arabic and English
      if (lowerMessage.contains('hi') || lowerMessage.contains('hello') || 
          lowerMessage.contains('مرحبا') || lowerMessage.contains('السلام عليكم') ||
          lowerMessage.contains('أهلا') || lowerMessage.contains('أهلين') ||
          lowerMessage.contains('صباح الخير') || lowerMessage.contains('مساء الخير') ||
          lowerMessage.contains('good morning') || lowerMessage.contains('good afternoon') ||
          lowerMessage.contains('good evening') || lowerMessage.contains('hey') ||
          lowerMessage.contains('sup') || lowerMessage.contains('what\'s up') ||
          lowerMessage.contains('السلام') || lowerMessage.contains('هلا') ||
          lowerMessage.contains('أهلا وسهلا') || lowerMessage.contains('أهلا بيك')) {
        response = "مرحباً! أنا المساعد الذكي لتطبيق Fix it. 😊\n\nاسمي FixBot وأنا هنا لمساعدتك في:\n• العثور على الخدمات المنزلية\n• التنقل بين صفحات التطبيق\n• الحصول على معلومات عن الخدمات\n• المساعدة والدعم الفني\n\nيمكنك أن تسألني عن:\n• الصفحة الرئيسية\n• المدينة والمنطقة\n• الطلبات والحجوزات\n• الملف الشخصي\n• طرق الدفع\n• الإشعارات\n• المساعدة والدعم\n\nكيف يمكنني مساعدتك اليوم؟";
      } else if (lowerMessage.contains('اسمك') || lowerMessage.contains('من انت') || lowerMessage.contains('من أنت') ||
                 lowerMessage.contains('what\'s your name') || lowerMessage.contains('who are you') ||
                 lowerMessage.contains('what is your name') || lowerMessage.contains('your name')) {
        response = "اسمي FixBot! 🤖\n\nأنا المساعد الذكي لتطبيق Fix it، مصمم لمساعدتك في العثور على الخدمات المنزلية والتنقل بسهولة في التطبيق.\n\nيمكنني مساعدتك في:\n• العثور على الخدمات المطلوبة\n• التنقل بين صفحات التطبيق\n• شرح كيفية استخدام التطبيق\n• الإجابة على أسئلتك\n\nهل تريد معرفة المزيد عن قدراتي؟";
      } else if (lowerMessage.contains('الرئيسية') || lowerMessage.contains('home') || lowerMessage.contains('البيت')) {
        response = "الصفحة الرئيسية تحتوي على:\n• البحث عن الخدمات\n• الخدمات الشائعة\n• العمال المميزين\n• العروض الخاصة\n\nللانتقال: اضغط على أيقونة البيت في الشريط السفلي";
        _navigateToHome();
      } else if (lowerMessage.contains('المدينة') || lowerMessage.contains('city') || lowerMessage.contains('المنطقة')) {
        response = "صفحة المدينة تتيح لك:\n• اختيار المدينة أو المنطقة\n• تصفية الخدمات حسب الموقع\n• العثور على الخدمات القريبة\n\nللانتقال: اضغط على أيقونة المدينة في الشريط السفلي";
        _navigateToCity();
      } else if (lowerMessage.contains('الطلبات') || lowerMessage.contains('order') || lowerMessage.contains('طلب')) {
        response = "صفحة الطلبات تحتوي على:\n• الطلبات المدفوعة\n• الطلبات غير المدفوعة\n• الطلبات المجدولة\n• تاريخ الطلبات\n\nللانتقال: اضغط على أيقونة الطلبات في الشريط السفلي";
        _navigateToOrders();
      } else if (lowerMessage.contains('الملف الشخصي') || lowerMessage.contains('profile') || lowerMessage.contains('حسابي')) {
        response = "الملف الشخصي يحتوي على:\n• معلومات الحساب\n• الإعدادات\n• الإشعارات\n• المساعدة والدعم\n• تسجيل الخروج\n\nللانتقال: اضغط على أيقونة الشخص في الشريط السفلي";
        _navigateToProfile();
      } else if (lowerMessage.contains('الدفع') || lowerMessage.contains('payment') || lowerMessage.contains('المدفوعات')) {
        response = "صفحة طرق الدفع تتيح لك:\n• إضافة بطاقة ائتمان\n• إدارة طرق الدفع\n• عرض سجل المدفوعات\n• إعدادات الدفع\n\nسأقوم بفتح صفحة طرق الدفع لك";
        _navigateToPayment();
      } else if (lowerMessage.contains('الإشعارات') || lowerMessage.contains('notification')) {
        response = "صفحة الإشعارات تعرض:\n• إشعارات الطلبات الجديدة\n• تحديثات الحالة\n• العروض والخصومات\n• الرسائل المهمة\n\nسأقوم بفتح صفحة الإشعارات لك";
        _navigateToNotifications();
      } else if (lowerMessage.contains('المساعدة') || lowerMessage.contains('help') || lowerMessage.contains('الدعم')) {
        response = "صفحة المساعدة والدعم تحتوي على:\n• الأسئلة الشائعة\n• دليل الاستخدام\n• التواصل مع الدعم\n• الإبلاغ عن مشكلة\n\nسأقوم بفتح صفحة المساعدة لك";
        _navigateToHelp();
      } else if (lowerMessage.contains('التقييم') || lowerMessage.contains('feedback') || lowerMessage.contains('رأي')) {
        response = "صفحة التقييم والرأي تتيح لك:\n• تقييم الخدمات\n• إرسال ملاحظات\n• تقييم العمال\n• اقتراحات للتحسين\n\nسأقوم بفتح صفحة التقييم لك";
        _navigateToFeedback();
      } else if (lowerMessage.contains('الخدمات') || lowerMessage.contains('services') || lowerMessage.contains('خدمة')) {
        response = "يمكنك العثور على الخدمات في:\n• الصفحة الرئيسية - للخدمات الشائعة\n• صفحة المدينة - لتصفية حسب الموقع\n• البحث - للعثور على خدمة محددة\n\nأي خدمة تبحث عنها تحديداً؟";
      } else if (lowerMessage.contains('كيف') || lowerMessage.contains('how') || lowerMessage.contains('طريقة')) {
        response = "للاستفادة من التطبيق:\n1. اختر المدينة من صفحة المدينة\n2. ابحث عن الخدمة المطلوبة في الصفحة الرئيسية\n3. اختر العامل المناسب\n4. احجز الخدمة وادفع\n5. تابع طلبك من صفحة الطلبات\n\nهل تحتاج مساعدة في خطوة معينة؟";
      } else if (lowerMessage.contains('شكرا') || lowerMessage.contains('thank')) {
        response = "العفو! سعيد بمساعدتك. إذا احتجت أي شيء آخر، لا تتردد في السؤال. 😊";
      } else {
        response = "عذراً، لم أفهم طلبك. يمكنني مساعدتك في:\n• التنقل بين الصفحات\n• العثور على الخدمات\n• معلومات عن التطبيق\n• المساعدة والدعم\n\nجرب أن تسأل عن 'الصفحة الرئيسية' أو 'الطلبات' أو 'المساعدة'";
      }
      
      _addBotMessage(response);
    });
  }

  void _navigateToHome() {
    // Use callback to change to home tab (index 0)
    widget.onTabChanged?.call(0);
  }

  void _navigateToCity() {
    // Use callback to change to city tab (index 1)[]
    widget.onTabChanged?.call(1);
  }

  void _navigateToOrders() {
    // Use callback to change to orders tab (index 2)
    widget.onTabChanged?.call(2);
  }

  void _navigateToProfile() {
    // Use callback to change to profile tab (index 3)
    widget.onTabChanged?.call(3);
  }

  void _navigateToPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PaymentMethodScreen()),
    );
  }

  void _navigateToNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NotificationScreen()),
    );
  }

  void _navigateToHelp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
    );
  }

  void _navigateToFeedback() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FeedbackScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom header for the chat tab
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                const Text(
                  'المساعد الذكي',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'متصل',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: message.isUser ? AppColors.primaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUser ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'اكتب رسالتك هنا...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onSubmitted: (_) => _handleSendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: _handleSendMessage,
            ),
          ),
        ],
      ),
    );
  }
} 