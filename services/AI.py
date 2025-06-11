import random

# Sample website data (replace with your actual website data or API calls)
WEBSITE_DATA = {
    "about": {
        "title": "About Our Company",
        "content": "We are a tech company specializing in AI solutions since 2015."
    },
    "services": {
        "title": "Our Services",
        "content": "We offer: 1. AI Development 2. Data Analysis 3. Chatbot Solutions"
    },
    "contact": {
        "title": "Contact Us",
        "content": "Email: info@example.com\nPhone: (123) 456-7890\nAddress: 123 Tech Street"
    },
    "pricing": {
        "title": "Pricing Plans",
        "content": "Basic: $99/month\nPro: $299/month\nEnterprise: Custom pricing"
    }
}

def website_chatbot(user_input, context=None):
    """
    A chatbot that provides information about a website.
    
    Args:
        user_input (str): The user's message
        context (dict, optional): Conversation context/memory. Defaults to None.
        
    Returns:
        tuple: (response_text, updated_context)
    """
    
    # Initialize context if not provided
    if context is None:
        context = {
            'current_page': None,
            'asked_about': [],
            'conversation_history': []
        }
    
    # Add current interaction to history
    context['conversation_history'].append(user_input)
    
    # Convert input to lowercase for easier processing
    input_lower = user_input.lower()
    
    # Check for website navigation queries
    for page in WEBSITE_DATA:
        if page in input_lower or WEBSITE_DATA[page]['title'].lower() in input_lower:
            context['current_page'] = page
            context['asked_about'].append(page)
            return format_page_response(page), context
    
    # Handle specific questions about current page
    if context['current_page']:
        current_page_data = WEBSITE_DATA[context['current_page']]
        if any(word in input_lower for word in ['what', 'how', 'explain', 'tell me']):
            return f"{current_page_data['title']}: {current_page_data['content']}", context
    
    # Handle general queries
    if "help" in input_lower:
        return get_help_response(), context
    
    if "menu" in input_lower or "options" in input_lower:
        return list_main_options(), context
    
    # Default responses
    return get_default_response(input_lower, context)

def format_page_response(page):
    """Format a proper response for a website page"""
    data = WEBSITE_DATA[page]
    return f"{data['title']}\n\n{data['content']}\n\nWhat would you like to know next?", page

def get_help_response():
    """Return help information"""
    return ("I can provide information about our website. Try asking about:\n"
           "- About us\n- Our services\n- Contact information\n- Pricing\n"
           "Or say 'menu' to see all options.")

def list_main_options():
    """List all main sections of the website"""
    options = "\n".join([f"- {WEBSITE_DATA[page]['title']}" for page in WEBSITE_DATA])
    return f"Here are our main sections:\n{options}\n\nWhich one interests you?"

def get_default_response(input_lower, context):
    """Generate appropriate default responses"""
    if any(word in input_lower for word in ['hi', 'hello', 'hey']):
        return "Hello! I'm the website assistant. How can I help you today?", context
    
    if any(word in input_lower for word in ['bye', 'goodbye']):
        return "Goodbye! Feel free to come back if you have more questions.", context
    
    suggestions = [
        "I'm not sure I understand. Try asking about our services or contact information.",
        "Could you rephrase that? I can tell you about our company, services, or pricing.",
        "I'm here to help with website information. Try asking about specific sections."
    ]
    return random.choice(suggestions), context


# Example usage
if name == "main":
    print("Website ChatBot: Hi! I can tell you about our website. Type 'quit' to exit.")
    context = None
    
    while True:
        user_input = input("You: ")
        if user_input.lower() in ['quit', 'exit']:
            print("Website ChatBot: Goodbye!")
            break
        
        response, context = website_chatbot(user_input, context)
        print("Website ChatBot:", response)