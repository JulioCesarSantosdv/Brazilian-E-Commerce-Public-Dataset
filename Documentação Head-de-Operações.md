# ⚙️ Dashboard Operacional — Olist Marketplace

## 🧩 Levantamento de Requisitos com o Head de Operações

Durante a reunião de levantamento de requisitos com o **Head de Operações**, o objetivo principal identificado foi **garantir a eficiência logística, a qualidade da entrega e a performance dos vendedores**, reduzindo custos e otimizando a experiência do cliente.

---

## 🎯 Contexto e Demanda de Negócio
O Head de Operações destacou que a área busca aumentar a **eficiência da cadeia logística** e reduzir atrasos de entrega. O foco está em:

- Acompanhar **prazos e tempos médios de entrega**;  
- Avaliar **desempenho de vendedores e transportadoras**;  
- Identificar **gargalos geográficos e operacionais**;  
- Otimizar **custos logísticos e de frete** com base nas dimensões dos produtos.

**Problema de Negócio:**
> 💬 “Como melhorar a performance operacional da entrega, reduzindo atrasos e custos, sem comprometer a experiência do cliente?”

---

## 🧠 Objetivo do Projeto (Visão Operacional)
Desenvolver um **Dashboard Operacional no Looker Studio** que permita:

- Monitorar eficiência e pontualidade das entregas;  
- Analisar desempenho de vendedores (SLA e TME);  
- Detectar regiões com maior concentração de atrasos;  
- Correlacionar o custo de frete com o peso e as dimensões do produto.

---

## 📈 KPIs e Métricas Definidas (Aprovadas)

| KPI / Métrica | Definição de Negócio | Fórmula de Cálculo (Base Olist) |
|----------------|----------------------|--------------------------------|
| **1. Tempo Médio de Entrega (TME)** | Tempo médio (em dias) entre aprovação e entrega ao cliente. | `AVG(order_delivered_customer_date - order_approved_at)` |
| **2. Taxa de Entrega no Prazo** | Percentual de pedidos entregues dentro ou antes do prazo estimado. | `COUNT(order_id WHERE order_delivered_customer_date ≤ order_estimated_delivery_date) / COUNT(order_id)` |
| **3. Tempo Médio de Preparação (SLA do Vendedor)** | Tempo médio entre aprovação e entrega à transportadora. | `AVG(order_delivered_carrier_date - order_approved_at)` |
| **4. Taxa de Pedidos com Problemas** | Percentual de pedidos cancelados ou indisponíveis. | `COUNT(order_id WHERE order_status IN ('canceled','unavailable')) / COUNT(order_id)` |
| **5. Top 5 Cidades com Maior Taxa de Atraso (NOVO)** | Identifica cidades com maior proporção de pedidos entregues após a data estimada. | `COUNT(order_id WHERE order_delivered_customer_date > order_estimated_delivery_date) / COUNT(order_id)` agrupado por `customers.customer_city` |
| **6. Custo Médio do Frete por Dimensão (NOVO)** | Correlação entre o valor médio do frete e o peso/comprimento do produto. | `AVG(order_items.freight_value)` agrupado por faixas de `product_weight_g` e `product_length_cm` |
| **7. Top 5 Vendedores com Pior TME** | Ranking dos vendedores com maior tempo médio de entrega. | `AVG(order_delivered_customer_date - order_approved_at)` por `sellers.seller_id (LIMIT 5)` |

---

## 🔍 Dimensões de Análise (Filtros do Dashboard)
Os indicadores poderão ser filtrados pelas seguintes dimensões:

1. **Vendedor:** `sellers.seller_id`  
2. **Região de Destino:** `customers.customer_city`, `customers.customer_state`  
3. **Categoria de Produto:** `products.product_category_name`

Essas dimensões permitem cruzar performance de entrega por região, vendedor e tipo de produto, facilitando a identificação de gargalos operacionais.

---

## 🗣️ Feedback do Stakeholder — Head de Operações
> “A lista está excelente. A inclusão da análise por Cidade com Maior Taxa de Atraso e a correlação entre Frete e Dimensões do Produto nos dará a inteligência necessária para otimizar custos e melhorar a experiência de entrega.  
> As dimensões de análise propostas são ideais para a gestão diária.”

---

## ✅ Resumo da Etapa
- **Status da Fase:** ✔️ Concluída (Requisitos Validados)  
- **Stakeholder:** Head de Operações  
- **Área de Negócio:** Operacional  
- **Próximo Passo:** Iniciar modelagem de dados no BigQuery e construção do Dashboard Operacional no Looker Studio.

---

## 📎 Links Relacionados
- 📚 [Documentação Técnica — Dashboard Operacional](https://github.com/seu-repositorio/docs/operacoes.md)  
- 📊 [Dashboard Operacional no Looker Studio](https://lookerstudio.google.com/reporting/seu-dashboard-operacoes)
