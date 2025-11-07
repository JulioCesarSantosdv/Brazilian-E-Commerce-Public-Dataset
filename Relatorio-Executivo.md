📊 RELATÓRIO EXECUTIVO - INVESTIGAÇÃO OLIST: ANÁLISE DE CHURN E RETENÇÃO
<div>
https://img.shields.io/badge/AN%C3%81LISE-DASHBOARDS-blue
https://img.shields.io/badge/BIGQUERY-SQL-yellow
https://img.shields.io/badge/INSIGHTS-ACION%C3%81VEIS-green
</div>

🎯 RESUMO EXECUTIVO  
📈 STATUS ATUAL CRÍTICO  
html  
<div style="background: #ff6b6b; padding: 15px; border-radius: 10px; color: white;">
⚠️ <strong>ALERTA:</strong> Apenas 3,05% dos clientes retornam para segunda compra
</div>

🎯 OBJETIVO DA INVESTIGAÇÃO  
Identificar as causas raiz da baixa retenção e propor soluções baseadas em dados para aumentar a fidelidade de clientes.

📊 METODOLOGIA  
🔍 ABORDAGEM ANALÍTICA  
html  
<table border="1" style="width:100%">
  <tr style="background: #4CAF50; color: white;">
    <th>Fase</th>
    <th>Objetivo</th>
    <th>Consultas</th>
  </tr>
  <tr>
    <td>📋 Diagnóstico</td>
    <td>Entender magnitude do problema</td>
    <td>6 consultas SQL</td>
  </tr>
  <tr>
    <td>🔍 Análise</td>
    <td>Identificar padrões e correlações</td>
    <td>9 consultas SQL</td>
  </tr>
  <tr>
    <td>🎯 Soluções</td>
    <td>Propor ações específicas</td>
    <td>Relatório Executivo</td>
  </tr>
</table>

📈 PRINCIPAIS DESCOBERTAS  
1️⃣ 🚨 PROBLEMA DE CHURN CRÍTICO  
sql  
-- INVESTIGAÇÃO 1: Taxa de Recorrência  
Única Compra:   92.507 clientes (96,95%)  
Recorrente:      2.913 clientes (3,05%)  -- PROBLEMA GRAVE!  

2️⃣ 💡 CLIENTES "ALTO VALOR" PERDIDOS  
sql  
-- INVESTIGAÇÃO 2: Segmentação Avançada  
Alto Valor + Única Compra: 1.244 clientes  -- OPORTUNIDADE PERDIDA!  
Alto Valor + Frequente:       12 clientes  -- RAROS CAMPEÕES!  

3️⃣ 🗺️ DISPARIDADE REGIONAL DRAMÁTICA  
sql  
-- INVESTIGAÇÃO 3: Performance por Estado  
SP: TME 8,18 dias | Taxa Atraso: 4,28%  -- EXCELENTE!  
RJ: TME 14,68 dias | Taxa Atraso: 11,25% -- PROBLEMÁTICO!  
RS: TME 14,51 dias | Taxa Atraso: 5,64%  -- LENTO MAS CONFIÁVEL  

🔍 CAUSAS RAIZ IDENTIFICADAS  
🎯 CORRELAÇÃO: EXPERIÊNCIA vs RETORNO  
html  
<div style="background: #e3f2fd; padding: 15px; border-radius: 10px; margin: 10px 0;">
<h4>📊 INVESTIGAÇÃO 6: Impacto da Primeira Experiência</h4>
<table border="1" style="width:100%">
  <tr style="background: #2196F3; color: white;">
    <th>Experiência</th>
    <th>Taxa Retorno</th>
    <th>Impacto</th>
  </tr>
  <tr>
    <td>TME Médio + Frete Baixo</td>
    <td>3,96%</td>
    <td>✅ Melhor</td>
  </tr>
  <tr>
    <td>TME Lento + Frete Alto</td>
    <td>2,86%</td>
    <td>❌ Pior (-28%)</td>
  </tr>
</table>
</div>

🚨 PRODUTOS "MATADORES" DE CLIENTES  
sql  
-- INVESTIGAÇÃO 7: Categorias com Zero Retenção  
cine_foto:                   0% retenção | 65 clientes perdidos  
construcao_ferramentas:      0% retenção | 97 clientes perdidos  
fashion_underwear:           0% retenção | 121 clientes perdidos  
artes:                       0% retenção | 202 clientes perdidos  

🏆 FÓRMULA DOS CLIENTES "CAMPEÕES"  
sql  
-- INVESTIGAÇÃO 9: Perfil dos Clientes Fiéis  
TME Médio + Frete Médio:   88 campeões | GMV: R$ 817  -- MAIOR VALOR  
TME Rápido + Frete Baixo:  64 campeões | GMV: R$ 717  
ZERO ATRASOS na 1ª compra: Fator crítico de sucesso  

🛠️ RECOMENDAÇÕES ESTRATÉGICAS  
🎯 AÇÕES IMEDIATAS (0-3 MESES)  
html  
<div style="background: #fff3cd; padding: 15px; border-radius: 10px; margin: 10px 0;">
<h4>🚀 PRIORIDADES CRÍTICAS</h4>
<ol>
  <li><strong>Revisar 6 categorias problemáticas</strong> - Análise de viabilidade</li>
  <li><strong>Implementar "Padrão Ouro" para primeira compra</strong>:
    <ul>
      <li>TME ≤ 14 dias</li>
      <li>Frete ≤ R$ 30</li>
      <li>Zero atrasos garantidos</li>
    </ul>
  </li>
  <li><strong>Otimizar operações no RJ</strong> - Reduzir TME de 21 para 14 dias</li>
</ol>
</div>

📈 ESTRATÉGIAS DE LONGO PRAZO (3-12 MESES)  
html  
<div style="background: #d4edda; padding: 15px; border-radius: 10px; margin: 10px 0;">
<h4>📊 PLANO DE RETENÇÃO</h4>
<ul>
  <li><strong>Programa de Fidelidade Pós-Primeira-Compra</strong></li>
  <li><strong>Gestão Ativa de Categorias de Risco</strong></li>
  <li><strong>Padrões Regionais de Qualidade</strong> baseados em métricas</li>
  <li><strong>Sistema de Alertas para Experiências Ruins</strong></li>
</ul>
</div>

📊 IMPACTO ESPERADO  
🎯 METAS QUANTIFICÁVEIS  
html  
<table border="1" style="width:100%">
  <tr style="background: #4CAF50; color: white;">
    <th>Métrica</th>
    <th>Atual</th>
    <th>Meta (6 meses)</th>
    <th>Impacto</th>
  </tr>
  <tr>
    <td>Taxa de Retenção</td>
    <td>3,05%</td>
    <td>4,00%</td>
    <td>+31%</td>
  </tr>
  <tr>
    <td>Clientes Recorrentes</td>
    <td>2.913</td>
    <td>3.800</td>
    <td>+887 clientes</td>
  </tr>
  <tr>
    <td>GMV de Clientes Fiéis</td>
    <td>R$ 2,3M</td>
    <td>R$ 3,0M</td>
    <td>+R$ 700K</td>
  </tr>
</table>

🔗 CONSULTAS SQL UTILIZADAS  
📁 ESTRUTURA DO PROJETO  
html  
<div style="background: #f8f9fa; padding: 15px; border-radius: 10px;">
<pre>
olist_analysis/
├── 📊 dashboard_comercial/
├── 📈 dashboard_marketing/
├── 🚚 dashboard_operacional/
├── 🔍 investigacoes_sql/
│   ├── 1001_analise_churn.sql
│   ├── 1002_segmentacao_avancada.sql
│   ├── 1003_performance_regional.sql
│   ├── 1004_clientes_alto_valor.sql
│   ├── 1005_sazonalidade_compras.sql
│   ├── 1006_experiencia_retorno.sql
│   ├── 1007_produtos_matadores.sql
│   ├── 1008_analise_categorias_problematicas.sql
│   └── 1009_clientes_campeoes.sql
└── 📋 relatorio_executivo.md
</pre>
</div>

💾 CÓDIGOS PRINCIPAIS  
<details> <summary>🔍 Consulta 1001 - Análise de Churn</summary>
sql
WITH clientes_recorrencia AS (
  SELECT 
    customer_unique_id,
    COUNT(DISTINCT order_id) as total_pedidos,
    MIN(data_compra) as primeira_compra,
    MAX(data_compra) as ultima_compra,
    CASE 
      WHEN COUNT(DISTINCT order_id) > 1 THEN 'Recorrente'
      ELSE 'Única Compra'
    END as tipo_cliente
  FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido`
  GROUP BY customer_unique_id
)
SELECT 
  tipo_cliente,
  COUNT(*) as total_clientes,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentual
FROM clientes_recorrencia
GROUP BY tipo_cliente;
</details>

<details> <summary>📈 Consulta 1006 - Experiência vs Retorno</summary>
sql
WITH experiencia_primeira_compra AS (
  SELECT 
    fp.customer_unique_id,
    AVG(fp.tempo_aprovacao_entrega_dias) as TME_primeira_compra,
    AVG(fp.indicador_atraso) as atraso_primeira_compra,
    AVG(fp.valor_frete) as frete_primeira_compra,
    COUNT(DISTINCT fp.order_id) as total_pedidos,
    CASE WHEN COUNT(DISTINCT fp.order_id) > 1 THEN 1 ELSE 0 END as retornou
  FROM `olist-sandbox-portfolio.olist_analysis.fato_pedido` fp
  GROUP BY fp.customer_unique_id
)
SELECT 
  CASE 
    WHEN TME_primeira_compra <= 7 THEN 'TME Rápido (≤7 dias)'
    WHEN TME_primeira_compra <= 14 THEN 'TME Médio (8-14 dias)'
    ELSE 'TME Lento (>14 dias)'
  END as grupo_tme,
  CASE 
    WHEN frete_primeira_compra <= 15 THEN 'Frete Baixo (≤R$15)'
    WHEN frete_primeira_compra <= 30 THEN 'Frete Médio (R$16-30)'
    ELSE 'Frete Alto (>R$30)'
  END as grupo_frete,
  COUNT(*) as total_clientes,
  AVG(retornou)*100 as taxa_retorno_percent
FROM experiencia_primeira_compra
GROUP BY grupo_tme, grupo_frete
ORDER BY taxa_retorno_percent DESC;
</details>

👥 RESPONSABILIDADES E PRÓXIMOS PASSOS  
🎯 OWNERSHIP  
html  
<table border="1" style="width:100%">
  <tr style="background: #FFC107; color: black;">
    <th>Área</th>
    <th>Responsável</th>
    <th>Prazo</th>
  </tr>
  <tr>
    <td>Operações</td>
    <td>Head de Operações</td>
    <td>30 dias</td>
  </tr>
  <tr>
    <td>Marketing</td>
    <td>Head de Marketing</td>
    <td>60 dias</td>
  </tr>
  <tr>
    <td>Comercial</td>
    <td>Head Comercial</td>
    <td>45 dias</td>
  </tr>
</table>

📅 PRÓXIMOS PASSOS  
Apresentação para stakeholders - Semana 1  
Implementação do "Padrão Ouro" - Semanas 2-4  
Revisão das categorias problemáticas - Semanas 3-6  
Monitoramento contínuo - A partir da semana 7  

<div align="center">
🏆 CONCLUSÃO  
"Garantir uma experiência consistente na primeira compra é a chave para transformar clientes únicos em fiéis"

📊 Relatório gerado em: Novembro 2025  
🔍 Base de dados: 99.441 pedidos | 95.420 clientes únicos
</div>

<div>
https://img.shields.io/badge/REPOSIT%C3%93RIO-GITHUB-black?style=for-the-badge&logo=github  
https://img.shields.io/badge/AN%C3%81LISE-BIGQUERY-orange?style=for-the-badge&logo=google  
https://img.shields.io/badge/VIZ-LOOKER_STUDIO-blue?style=for-the-badge&logo=google  
</div>

