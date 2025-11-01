<h1>Dashboard Comercial — Olist Marketplace</h1>
<h2>Levantamento de Requisitos com o Diretor Comercial</h2>

<p>Durante a reunião de levantamento de requisitos com o <strong>Diretor Comercial</strong>, o objetivo principal identificado foi <strong>maximizar a receita e o volume de vendas do marketplace</strong>. A seguir, é apresentada a documentação completa dos <strong>KPIs e Métricas</strong> propostos, incluindo definições de negócio, fórmulas de cálculo e feedback do stakeholder.</p>

<hr>

<h2> Contexto e Demanda de Negócio</h2>
<p>O Diretor Comercial destacou que, embora o volume de pedidos da Olist seja expressivo, ainda existem oportunidades de crescimento ao:</p>
<ul>
  <li>Identificar os <strong>vendedores mais rentáveis</strong>;</li>
  <li><strong>Reduzir inadimplência</strong> e cancelamentos;</li>
  <li>Compreender a <strong>rentabilidade por categoria de produto</strong>;</li>
  <li>Direcionar o esforço comercial para <strong>regiões e segmentos mais lucrativos</strong>.</li>
</ul>

<p><strong>Problema de Negócio:</strong></p>
<blockquote> “Quais vendedores, categorias e regiões mais contribuem para o aumento do GMV e rentabilidade?”</blockquote>

<hr>

<h2> Objetivo do Projeto (Visão Comercial)</h2>
<p>Construir um <strong>Dashboard Comercial no Looker Studio</strong> que forneça ao Diretor Comercial uma visão 360° da performance de vendas, permitindo:</p>
<ul>
  <li>Acompanhar a evolução do GMV e do Ticket Médio;</li>
  <li>Monitorar cancelamentos e inadimplência;</li>
  <li>Identificar vendedores e categorias de maior retorno financeiro;</li>
  <li>Suportar decisões estratégicas de expansão e campanhas comerciais.</li>
</ul>

<hr>

<h2> KPIs e Métricas Definidas (Atualizadas)</h2>

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
      <td><strong>1. GMV (Gross Merchandise Volume)</strong></td>
      <td>Valor total de mercadorias vendidas no período.</td>
      <td>SUM(order_items.price + order_items.freight_value)</td>
    </tr>
    <tr>
      <td><strong>2. Ticket Médio (AOV)</strong></td>
      <td>Valor médio gasto por pedido.</td>
      <td>GMV / COUNT(DISTINCT orders.order_id)</td>
    </tr>
    <tr>
      <td><strong>3. Volume de Pedidos</strong></td>
      <td>Quantidade total de pedidos realizados.</td>
      <td>COUNT(DISTINCT orders.order_id)</td>
    </tr>
    <tr>
      <td><strong>4. Taxa de Cancelamento</strong></td>
      <td>Percentual de pedidos cancelados.</td>
      <td>COUNT(orders WHERE order_status = 'canceled') / COUNT(orders)</td>
    </tr>
    <tr>
      <td><strong>5. Taxa de Inadimplência (NOVO)</strong></td>
      <td>Percentual de pedidos com falha ou estorno no pagamento.</td>
      <td>COUNT(orders WHERE order_status = 'unavailable' OR (order_status = 'canceled' AND order_payments.payment_type = 'credit_card')) / COUNT(orders)</td>
    </tr>
    <tr>
      <td><strong>6. Top 5 Vendedores por GMV (NOVO)</strong></td>
      <td>Ranking dos vendedores com maior volume de vendas.</td>
      <td>SUM(order_items.price) agrupado por sellers.seller_id (LIMIT 5)</td>
    </tr>
    <tr>
      <td><strong>7. Receita por Categoria (NOVO)</strong></td>
      <td>Valor total de vendas por categoria de produto.</td>
      <td>SUM(order_items.price) agrupado por products.product_category_name</td>
    </tr>
    <tr>
      <td><strong>8. Variação do GMV (Mês a Mês)</strong></td>
      <td>Percentual de crescimento ou queda no GMV.</td>
      <td>(GMV Mês Atual - GMV Mês Anterior) / GMV Mês Anterior</td>
    </tr>
  </tbody>
</table>

<hr>

<h2> Dimensões de Análise (Filtros do Dashboard)</h2>
<p>Os indicadores poderão ser filtrados dinamicamente pelas seguintes dimensões:</p>
<ol>
  <li><strong>Categoria de Produto:</strong> products.product_category_name</li>
  <li><strong>Região Geográfica do Cliente (Estado):</strong> customers.customer_state</li>
  <li><strong>Período de Tempo (Ano/Mês/Dia):</strong> orders.order_purchase_timestamp</li>
</ol>

<p>Essas dimensões permitem identificar tendências regionais, sazonalidades de vendas e variações de performance por categoria.</p>

<hr>

<h2> Feedback do Stakeholder — Diretor Comercial</h2>
<blockquote>
  <p>“A lista de KPIs está muito mais completa e alinhada com as minhas prioridades.  
  A inclusão da <strong>Taxa de Inadimplência</strong> e da <strong>Receita por Categoria</strong> é essencial.  
  As dimensões de análise (Categoria, Estado e Tempo) permitirão decisões estratégicas fundamentadas.  
  Podemos considerar esta lista de indicadores <strong>APROVADA</strong> para o Dashboard Comercial.”</p>
</blockquote>

<hr>

<h2>Resumo da Etapa</h2>
<ul>
  <li><strong>Status da Fase:</strong>  Concluída (Requisitos Validados)</li>
  <li><strong>Stakeholder:</strong> Diretor Comercial</li>
  <li><strong>Área de Negócio:</strong> Comercial</li>
</ul>

<hr>


<p><a href="https://github.com/JulioCesarSantosdv/Brazilian-E-Commerce-Public-Dataset/blob/main/README.md#passo-5-hip%C3%B3teses-anal%C3%ADticas" target="_blank" rel="noopener noreferrer">Voltar</a></p>





