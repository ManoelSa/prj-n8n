-- Criação da estrutura para o CRM e Histórico
CREATE TABLE IF NOT EXISTS leads (
    id SERIAL PRIMARY KEY,
    whatsapp_id TEXT UNIQUE NOT NULL,
    name TEXT,
    phone TEXT,
    category TEXT DEFAULT 'Geral', -- assistência técnica, peças, fabricação, orçamento, informações gerais
    status TEXT DEFAULT 'Novo',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS message_history (
    id SERIAL PRIMARY KEY,
    whatsapp_id TEXT NOT NULL,
    content TEXT,
    direction TEXT, -- inbound, outbound
    sender_name TEXT,
    message_type TEXT DEFAULT 'text',
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (whatsapp_id) REFERENCES leads(whatsapp_id) ON DELETE CASCADE
);

-- Index para busca rápida por WhatsApp ID
CREATE INDEX IF NOT EXISTS idx_leads_whatsapp_id ON leads(whatsapp_id);
CREATE INDEX IF NOT EXISTS idx_history_whatsapp_id ON message_history(whatsapp_id);
-- Tabela para Memória Persistente da IA (LangChain)
CREATE TABLE IF NOT EXISTS ai_chat_history (
    id SERIAL PRIMARY KEY,
    session_id TEXT NOT NULL,
    message JSONB NOT NULL
);

-- Index para busca rápida por Sessão
CREATE INDEX IF NOT EXISTS idx_chat_history_session_id ON ai_chat_history(session_id);
