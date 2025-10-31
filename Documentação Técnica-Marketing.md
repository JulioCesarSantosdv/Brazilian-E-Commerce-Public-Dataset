## 💡 Área de Marketing (Gerente de Marketing)
**🎯 Objetivo:** Entender perfil do cliente e eficácia das campanhas  

**📚 Documentação:** [Ver Documentação de Marketing](https://github.com/seu-repositorio/docs/marketing.md)  
**📈 Dashboard Looker Studio:** [Acessar Dashboard Marketing](https://lookerstudio.google.com/reporting/seu-dashboard-marketing)

### 🔹 KPIs Principais

| KPI | Definição | Fórmula (Base Olist) |
|-----|------------|----------------------|
| **LTV** | Valor total do cliente | `(Receita Média) × (Frequência) × (Tempo Retenção)` |
| **Taxa de Clientes Recorrentes** | Clientes com mais de uma compra | `COUNT(customer_unique_id > 1) / total` |
| **Segmentação RFM** | Classificação por valor | Pontuação `R` (Recência), `F` (Frequência), `M` (Monetário) |
| **Categoria de Primeira Compra** | Produto que atraiu o cliente | `MIN(order_purchase_timestamp)` por categoria |
| **Taxa de Avaliações Negativas** | Indicador de insatisfação | `COUNT(review_score ≤ 2) / total` |

**📊 Dimensões de Análise:** Segmento RFM, Categoria de Produto, Estado do Cliente

---

## ⚙️ Área Operacional (Head de Operações)
**🎯 Objetivo:** Garantir eficiência logística e qualidade da entrega  

**📚 Documentação:** [Ver Documentação Operacional](https://github.com/seu-repositorio/docs/operacoes.md)  
**📈 Dashboard Looker Studio:** [Acessar Dashboard Operacional](https://lookerstudio.google.com/reporting/seu-dashboard-operacoes)

### 🔹 KPIs Principais

| KPI | Definição | Fórmula (Base Olist) |
|-----|------------|----------------------|
| **Tempo Médio de Entrega** | Dias entre aprovação e entrega | `AVG(delivered_date - approved_at)` |
| **Taxa de Entrega no Prazo** | Entregues dentro do estimado | `COUNT(delivered ≤ estimated) / total` |
| **Tempo de Preparação** | SLA do vendedor | `AVG(carrier_date - approved_at)` |
| **Top 5 Cidades com Atraso** | Regiões críticas | Agregação por `customer_city` |
| **Custo do Frete por Dimensão** | Correlação frete × peso | `AVG(freight_value)` por faixa de peso |

**📊 Dimensões de Análise:** Vendedor, Região de Destino, Categoria de Produto

---

📘 **Observação:**  
Os links acima são exemplos — substitua pelas URLs reais da sua documentação e dos painéis Looker Studio correspondentes.