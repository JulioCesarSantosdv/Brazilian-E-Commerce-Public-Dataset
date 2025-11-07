<h1>Relatório de Investigação SQL — Análise de Churn e Retenção Olist</h1>

<h2>Contexto e Objetivo da Investigação</h2>
<p>
Com base nos dashboards implementados, identificamos que apenas <strong>3,05% dos clientes retornam para segunda compra</strong>.  
Esta investigação teve como objetivo descobrir as <strong>causas raiz da baixa retenção</strong> e propor soluções baseadas em dados.
</p>

<hr>

<h2>Metodologia de Análise</h2>

<h3>Abordagem Investigativa</h3>
<ul>
  <li>6 consultas SQL para diagnóstico do problema;</li>
  <li>9 consultas SQL para análise de padrões e correlações;</li>
  <li>Análise multidimensional: experiência do cliente, fatores regionais e categorias de produtos.</li>
</ul>

<h3>Fontes de Dados Utilizadas</h3>
<ul>
  <li><strong>Tabela fato_pedido:</strong> 99.441 pedidos;</li>
  <li><strong>Visualizações especializadas</strong> do projeto Olist;</li>
  <li><strong>Dados de 95.420 clientes únicos.</strong></li>
</ul>

<hr>

<h2>Principais Descobertas</h2>

<h3>1. Problema de Churn Crítico Confirmado</h3>
<pre><code>-- Resultado da Investigação 1
Única Compra:   92.507 clientes (96,95%)
Recorrente:      2.913 clientes (3,05%)
</code></pre>

<h3>2. Clientes de Alto Valor Não Retornam</h3>
<pre><code>-- Resultado da Investigação 2
Alto Valor + Única Compra: 1.244 clientes
Alto Valor + Frequente:       12 clientes
</code></pre>

<h3>3. Disparidade Regional Significativa</h3>
<pre><code>-- Resultado da Investigação 3
SP: TME 8,18 dias | Taxa Atraso: 4,28%
RJ: TME 14,68 dias | Taxa Atraso: 11,25%
RS: TME 14,51 dias | Taxa Atraso: 5,64%
</code></pre>

<hr>

<h2>Causas Raiz Identificadas</h2>

<h3>Correlação entre Experiência e Retorno</h3>
<pre><code>-- Investigação 6: Impacto da Primeira Experiência
TME Médio + Frete Baixo:    3,96% retorno
TME Lento + Frete Alto:     2,86% retorno (-28%)
</code></pre>

<h3>Produtos com Zero Retenção</h3>
<pre><code>-- Investigação 7: Categorias Problemáticas
cine_foto:                   0% retenção | 65 clientes
construcao_ferramentas:      0% retenção | 97 clientes
fashion_underwear:           0% retenção | 121 clientes
artes:                       0% retenção | 202 clientes
</code></pre>

<h3>Fórmula dos Clientes Campeões</h3>
<pre><code>-- Investigação 9: Perfil dos Clientes Fiéis
TME Médio + Frete Médio:   88 campeões | GMV: R$ 817
ZERO ATRASOS na 1ª compra: Fator crítico
</code></pre>

<hr>

<h2>Recomendações Estratégicas</h2>

<h3>Ações Imediatas (0–3 meses)</h3>
<ul>
  <li>Implementar "<strong>Padrão Ouro</strong>" para primeira compra:
    <ul>
      <li>TME ≤ 14 dias</li>
      <li>Frete ≤ R$ 30</li>
      <li>Zero atrasos garantidos</li>
    </ul>
  </li>
  <li>Revisar 6 categorias problemáticas com zero retenção;</li>
  <li>Otimizar operações no RJ — reduzir TME de 21 para 14 dias.</li>
</ul>

<h3>Estratégias de Longo Prazo (3–12 meses)</h3>
<ul>
  <li>Programa de fidelidade pós-primeira-compra;</li>
  <li>Gestão ativa de categorias de risco;</li>
  <li>Padrões regionais de qualidade baseados em métricas.</li>
</ul>

<hr>

<h2>Impacto Esperado</h2>

<table>
  <thead>
    <tr>
      <th>Métrica</th>
      <th>Atual</th>
      <th>Meta (6 meses)</th>
      <th>Impacto</th>
    </tr>
  </thead>
  <tbody>
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
  </tbody>
</table>

<hr>

<h2>Consultas SQL Desenvolvidas</h2>

<h3>Estrutura das Investigações</h3>
<pre><code>investigacoes_sql/
├── 1001_analise_churn.sql
├── 1002_segmentacao_avancada.sql
├── 1003_performance_regional.sql
├── 1004_clientes_alto_valor.sql
├── 1005_sazonalidade_compras.sql
├── 1006_experiencia_retorno.sql
├── 1007_produtos_matadores.sql
├── 1008_analise_categorias_problematicas.sql
└── 1009_clientes_campeoes.sql
</code></pre>

<h3>Código da Consulta Principal</h3>
<details>
  <summary><strong>Consulta 1001 — Análise de Churn</strong></summary>
  <pre><code>WITH clientes_recorrencia AS (
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
  </code></pre>
</details>

<hr>

<h2>Conclusão</h2>
<p>
A investigação revelou que a <strong>experiência consistente na primeira compra</strong> é o fator determinante para retenção de clientes.  
A implementação do <strong>"Padrão Ouro" operacional</strong> pode aumentar significativamente a taxa de retenção e o valor vitalício do cliente.
</p>

<p><strong>Próximos Passos:</strong> Apresentação para stakeholders e implementação das recomendações prioritárias.</p>

<hr>

<p>
<a href="https://github.com/JulioCesarSantosdv/Brazilian-E-Commerce-Public-Dataset/blob/main/README.md#passo-5-hipóteses-analíticas" target="_blank" rel="noopener noreferrer">Voltar</a>
</p>
