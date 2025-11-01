<h1>Dashboard de Clientes e Marketing — Olist Marketplace</h1>
<h2>Levantamento de Requisitos com o Gerente de Marketing</h2>

<p>Durante a reunião de levantamento de requisitos com o <strong>Gerente de Marketing</strong>, o objetivo principal identificado foi <strong>compreender o perfil do cliente, o comportamento de compra e a eficácia das campanhas</strong> para aumentar a retenção e o valor vitalício do cliente (LTV). A seguir, é apresentada a documentação completa dos <strong>KPIs e Métricas</strong> propostos, incluindo definições de negócio, fórmulas de cálculo e feedback do stakeholder.</p>

<hr>

<h2>Contexto e Demanda de Negócio</h2>
<p>O Gerente de Marketing destacou que, embora a base de clientes da Olist seja ampla, ainda há oportunidades de crescimento por meio de:</p>
<ul>
  <li>Compreender o <strong>ciclo de valor vitalício do cliente (LTV)</strong>;</li>
  <li>Aumentar a <strong>recorrência de compra</strong> e reduzir churn;</li>
  <li>Identificar <strong>categorias de maior atração na primeira compra</strong>;</li>
  <li>Melhorar a <strong>experiência e satisfação do cliente</strong> por meio das avaliações.</li>
</ul>

<p><strong>Problema de Negócio:</strong></p>
<blockquote> “Quais características e comportamentos distinguem os clientes com maior LTV e probabilidade de recompra?”</blockquote>

<hr>

<h2>Objetivo do Projeto (Visão de Marketing)</h2>
<p>Construir um <strong>Dashboard de Clientes e Marketing no Looker Studio</strong> que permita:</p>
<ul>
  <li>Analisar o ciclo de compra do cliente (da primeira compra à recompra);</li>
  <li>Identificar segmentos de maior valor e risco (RFM);</li>
  <li>Monitorar a satisfação dos clientes por meio das avaliações;</li>
  <li>Gerar insights acionáveis para campanhas de aquisição e retenção.</li>
</ul>

<hr>

<h2>KPIs e Métricas Definidas (Atualizadas)</h2>

<table>
  <thead>
    <tr>
      <th>KPI / Métrica</th>
      <th>Definição de Negócio</th>
      <th>Fórmula de Cálculo (Base Olist)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>1. LTV (Lifetime Value)</strong></td>
      <td>Valor total de receita que um cliente gera durante todo o relacionamento.</td>
      <td>(Receita Média por Cliente) × (Frequência Média de Compra) × (Tempo Médio de Retenção) (simulado)</td>
    </tr>
    <tr>
      <td><strong>2. Taxa de Clientes Recorrentes</strong></td>
      <td>Percentual de clientes que fizeram mais de uma compra.</td>
      <td>COUNT(DISTINCT customer_unique_id WHERE COUNT(order_id) > 1) / COUNT(DISTINCT customer_unique_id)</td>
    </tr>
    <tr>
      <td><strong>3. Segmentação RFM</strong></td>
      <td>Classificação dos clientes com base em Recência, Frequência e Valor Monetário.</td>
      <td>Agrupamento com base nas pontuações de R, F e M (ex: “Campeões”, “Em Risco”).</td>
    </tr>
    <tr>
      <td><strong>4. Categoria de Primeira Compra (NOVO)</strong></td>
      <td>Categoria de produto mais comprada na primeira transação.</td>
      <td>COUNT(order_id) por products.product_category_name onde order_purchase_timestamp é o mínimo do cliente.</td>
    </tr>
    <tr>
      <td><strong>5. Taxa de Avaliações Negativas (NOVO)</strong></td>
      <td>Percentual de avaliações com score 1 ou 2, indicando insatisfação.</td>
      <td>COUNT(review_score ≤ 2) / COUNT(review_score total)</td>
    </tr>
    <tr>
      <td><strong>6. Tempo Médio de Avaliação (NOVO)</strong></td>
      <td>Tempo médio entre a entrega do pedido e o envio da avaliação.</td>
      <td>AVG(order_review_timestamp - order_delivered_customer_date)</td>
    </tr>
    <tr>
      <td><strong>7. Top 5 Estados por Volume de Clientes</strong></td>
      <td>Identifica as regiões com maior concentração de clientes.</td>
      <td>COUNT(DISTINCT customer_unique_id) por customer_state</td>
    </tr>
  </tbody>
</table>

<hr>

<h2>Dimensões de Análise (Filtros do Dashboard)</h2>
<p>Os indicadores poderão ser filtrados dinamicamente pelas seguintes dimensões:</p>
<ol>
  <li><strong>Segmento RFM:</strong> comportamento e valor do cliente;</li>
  <li><strong>Categoria de Produto:</strong> identificação de interesses e potencial de cross-sell;</li>
  <li><strong>Estado do Cliente:</strong> regionalização de campanhas e análise geográfica.</li>
</ol>

<p>Essas dimensões permitirão cruzar dados de comportamento, valor e geolocalização para personalizar ações de marketing e aumentar a retenção.</p>

<hr>

<h2>Feedback do Stakeholder — Gerente de Marketing</h2>
<blockquote>
  <p>“A lista está perfeita. A inclusão da <strong>Categoria de Primeira Compra</strong> nos dará um insight valioso para otimizar o funil de aquisição, e o foco nas <strong>Avaliações Negativas</strong> e no <strong>Tempo Médio de Avaliação</strong> nos permitirá agir rapidamente em casos de insatisfação.  
  As dimensões de análise propostas são exatamente o que precisamos para segmentar nossas campanhas.  
  Podemos considerar esta lista de indicadores <strong>APROVADA</strong> para o Dashboard de Clientes e Marketing.”</p>
</blockquote>

<hr>

<h2>Resumo da Etapa</h2>
<ul>
  <li><strong>Status da Fase:</strong>  Concluída (Requisitos Validados)</li>
  <li><strong>Stakeholder:</strong> Gerente de Marketing</li>
  <li><strong>Área de Negócio:</strong> Marketing / Clientes</li>

</ul>

<hr>

<p><a href="https://github.com/JulioCesarSantosdv/Brazilian-E-Commerce-Public-Dataset/blob/main/README.md#passo-5-hip%C3%B3teses-anal%C3%ADticas" target="_blank" rel="noopener noreferrer">Voltar</a></p>


