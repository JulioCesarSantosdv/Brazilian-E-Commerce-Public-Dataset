<h1> Dashboard de Clientes e Marketing — Olist Marketplace</h1>
<h2> Levantamento de Requisitos com o Gerente de Marketing</h2>

<p>Durante a reunião de levantamento de requisitos com o <strong>Gerente de Marketing</strong>, o objetivo principal identificado foi <strong>entender o perfil do cliente, o comportamento de compra e a eficácia das campanhas</strong> para aumentar a <strong>retenção</strong> e o <strong>valor do cliente (LTV)</strong>.</p>

<p>A seguir, é apresentada a documentação completa dos <strong>KPIs e Métricas</strong> propostos, incluindo definições de negócio, fórmulas de cálculo (baseadas no dataset da Olist) e o <strong>feedback do stakeholder</strong>.</p>

<hr>

<h2> Levantamento de Requisitos: Foco no Gerente de Marketing</h2>

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
      <td>Valor total de receita que um cliente gera para a empresa durante todo o seu relacionamento.</td>
      <td>(Receita Média por Cliente) × (Frequência Média de Compra) × (Tempo Médio de Retenção)</td>
    </tr>
    <tr>
      <td><strong>2. Taxa de Clientes Recorrentes</strong></td>
      <td>Proporção de clientes que realizaram mais de uma compra.</td>
      <td>COUNT(DISTINCT customer_unique_id WHERE COUNT(order_id) > 1) / COUNT(DISTINCT customer_unique_id)</td>
    </tr>
    <tr>
      <td><strong>3. Recência (Recency)</strong></td>
      <td>Tempo médio desde a última compra do cliente.</td>
      <td>AVG(CURRENT_DATE - MAX(order_purchase_timestamp))</td>
    </tr>
    <tr>
      <td><strong>4. Segmentação RFM</strong></td>
      <td>Classificação dos clientes com base em Recência, Frequência e Valor Monetário.</td>
      <td>Pontuação R (Recência), F (Frequência), M (Monetário)</td>
    </tr>
    <tr>
      <td><strong>5. CAC (Custo de Aquisição de Cliente)</strong></td>
      <td>Custo total de marketing e vendas para adquirir um novo cliente.</td>
      <td>Não calculável diretamente (dados de campanha não disponíveis na Olist)</td>
    </tr>
    <tr>
      <td><strong>6. Top 5 Estados por Volume de Clientes</strong></td>
      <td>Regiões com a maior base de clientes.</td>
      <td>COUNT(DISTINCT customer_unique_id) por customers.customer_state</td>
    </tr>
    <tr>
      <td><strong>7. Distribuição de Avaliações (Score)</strong></td>
      <td>Percentual de clientes que deram notas 1, 2, 3, 4 e 5.</td>
      <td>COUNT(review_score) por score / COUNT(review_score total)</td>
    </tr>
  </tbody>
</table>

<hr>

<h2> Feedback do Stakeholder — Gerente de Marketing</h2>
<blockquote>
  <p>“A lista é excelente e cobre o essencial para a gestão da base de clientes.  
  A inclusão do LTV, da Taxa de Recorrência e, principalmente, da Segmentação RFM mostra que o Analista de Dados entende a nossa necessidade de ir além do faturamento bruto e focar na qualidade e no potencial de longo prazo do cliente.”</p>
  <p>No entanto, o gerente destacou dois pontos cruciais:</p>
  <ol>
    <li><strong>Foco na Primeira Compra:</strong> É vital entender qual categoria atrai o novo cliente. Isso ajuda o time de aquisição a otimizar campanhas de onboarding.</li>
    <li><strong>Qualidade da Avaliação:</strong> Deseja-se medir a <em>Taxa de Avaliações Negativas (Score 1 e 2)</em> e o <em>Tempo Médio de Avaliação</em> como um proxy da experiência imediata do cliente.</li>
  </ol>
</blockquote>

<hr>

<h2> Solicitações de Ajuste</h2>
<ul>
  <li>Adicionar KPI: <strong>Categoria de Produto mais comprada na Primeira Transação</strong>;</li>
  <li>Ajustar KPI: <strong>Distribuição de Avaliações</strong> → focar em <strong>Taxa de Avaliações Negativas</strong> e <strong>Tempo Médio de Avaliação</strong>.</li>
</ul>

<hr>

<h2> Levantamento de Requisitos: Versão Atualizada (Pós-Feedback)</h2>

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
      <td>Valor total de receita gerada por cliente durante seu relacionamento.</td>
      <td>(Receita Média) × (Frequência Média) × (Tempo de Retenção)</td>
    </tr>
    <tr>
      <td><strong>2. Taxa de Clientes Recorrentes</strong></td>
      <td>Percentual de clientes com mais de uma compra.</td>
      <td>COUNT(DISTINCT customer_unique_id WHERE COUNT(order_id) > 1) / COUNT(DISTINCT customer_unique_id)</td>
    </tr>
    <tr>
      <td><strong>3. Segmentação RFM</strong></td>
      <td>Classificação de clientes com base em Recência, Frequência e Valor Monetário.</td>
      <td>Pontuação R, F, M → Grupos (Campeões, Em Risco, Inativos, etc.)</td>
    </tr>
    <tr>
      <td><strong>4. Categoria de Primeira Compra (NOVO)</strong></td>
      <td>Categoria de produto mais comum na primeira transação.</td>
      <td>Agregação por product_category_name onde order_purchase_timestamp é o mínimo para cada customer_unique_id</td>
    </tr>
    <tr>
      <td><strong>5. Taxa de Avaliações Negativas (NOVO)</strong></td>
      <td>Percentual de avaliações com score 1 ou 2 (indicador de insatisfação).</td>
      <td>COUNT(review_score ≤ 2) / COUNT(review_score total)</td>
    </tr>
    <tr>
      <td><strong>6. Tempo Médio de Avaliação (NOVO)</strong></td>
      <td>Tempo médio entre a entrega do pedido e o envio da avaliação.</td>
      <td>AVG(order_review_timestamp - order_delivered_customer_date)</td>
    </tr>
    <tr>
      <td><strong>7. Top 5 Estados por Volume de Clientes</strong></td>
      <td>Estados com maior base de clientes.</td>
      <td>COUNT(DISTINCT customer_unique_id) por customer_state</td>
    </tr>
  </tbody>
</table>

<hr>

<h2> Dimensões de Análise (Filtros do Dashboard)</h2>
<ol>
  <li><strong>Segmento RFM</strong> (comportamento e valor do cliente);</li>
  <li><strong>Categoria de Produto</strong> (para campanhas de cross-sell e up-sell);</li>
  <li><strong>Estado do Cliente</strong> (regionalização de campanhas).</li>
</ol>

<hr>

<h2>💬 Confirmação do Stakeholder</h2>
<blockquote>
  <p>“Sim, Analista de Dados. Esta lista está perfeita.  
  A inclusão da <strong>Categoria de Primeira Compra</strong> nos dará um insight valioso para otimizar o funil de aquisição,  
  e o foco nas <strong>Avaliações Negativas</strong> e no <strong>Tempo Médio de Avaliação</strong> nos permitirá agir rapidamente em casos de insatisfação.  
  As dimensões de análise propostas são exatamente o que precisamos para segmentar nossas campanhas.  
  Podemos considerar esta lista de KPIs e Métricas <strong>APROVADA</strong> para o Dashboard de Clientes/Marketing.”</p>
</blockquote>

<hr>

<h2> Resumo da Etapa</h2>
<ul>
  <li><strong>Status da Fase:</strong> Concluída (Requisitos Validados)</li>
  <li><strong>Stakeholder:</strong> Gerente de Marketing</li>
  <li><strong>Área de Negócio:</strong> Marketing</li>
</ul>

<hr>


