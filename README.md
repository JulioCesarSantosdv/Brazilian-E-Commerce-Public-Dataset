<h1>DASHBOARDS ESTRATÉGICOS PARA O E-COMMERCE OLIST: VISÃO 360° DA PERFORMANCE COMERCIAL, CLIENTES E OPERAÇÕES</h1>
<hr>

<h2>Sumário</h2>
<ul>
  <li><a href="#visão-geral-do-projeto">Visão Geral do Projeto</a></li>
  <li><a href="#metodologia-e-abordagem">Metodologia e Abordagem</a></li>
  <li><a href="#estratégia-de-solução">Estratégia de Solução</a></li>
  <ul>
    <li><a href="#passo-1-resumir-o-contexto-em-uma-pergunta-aberta">Passo 1: Pergunta Aberta</a></li>
    <li><a href="#passo-2-transformar-uma-pergunta-aberta-em-uma-pergunta-fechada">Passo 2: Pergunta Fechada</a></li>
    <li><a href="#passo-3-definição-do-fato">Passo 3: Definição do Fato</a></li>
    <li><a href="#passo-4-identificação-das-dimensões">Passo 4: Identificação das Dimensões</a></li>
    <li><a href="#passo-5-hipóteses-analíticas">Passo 5: Hipóteses Analíticas</a></li>
    <li><a href="#passo-6-critérios-de-priorização">Passo 6: Critérios de Priorização</a></li>
    <li><a href="#passo-7-priorização-das-hipóteses">Passo 7: Priorização das Hipóteses</a></li>
  </ul>
  <li><a href="#modelagem-de-dados-schema-estrela">Modelagem de Dados (Schema Estrela)</a></li>
  <li><a href="#estrutura-dos-dashboards">Estrutura dos Dashboards</a></li>
  <li><a href="#tecnologias-utilizadas">Tecnologias Utilizadas</a></li>
  <li><a href="#lições-aprendidas">Lições Aprendidas</a></li>
</ul>

<hr>

<h2 id="visão-geral-do-projeto">Visão Geral do Projeto</h2>
<p>
Este projeto consiste na construção de uma suíte de dashboards analíticos no <strong>Looker Studio</strong> para fornecer uma visão 360° da operação do e-commerce <strong>Olist</strong>. 
O objetivo é transformar dados brutos em insights estratégicos acionáveis, simulando um ciclo completo de análise de dados seguindo a metodologia <strong>CRISP-DM</strong>.
</p>
<p>
A solução abrange três pilares estratégicos: <strong>Performance Comercial</strong>, <strong>Comportamento do Cliente</strong> e <strong>Eficiência Operacional</strong>, 
atendendo às necessidades do <strong>Diretor Comercial</strong>, <strong>Gerente de Marketing</strong> e <strong>Head de Operações</strong>.
</p>

<hr>

<h2 id="metodologia-e-abordagem">Metodologia e Abordagem</h2>
<h3>CRISP-DM Aplicado</h3>
<ul>
  <li><strong>Entendimento do Negócio</strong> – Levantamento de requisitos com stakeholders</li>
  <li><strong>Entendimento dos Dados</strong> – Análise dos datasets da Olist</li>
  <li><strong>Preparação dos Dados</strong> – Modelagem e transformação</li>
  <li><strong>Modelagem</strong> – Criação do schema analítico</li>
  <li><strong>Avaliação</strong> – Validação com stakeholders</li>
  <li><strong>Implantação</strong> – Dashboards no Looker Studio</li>
</ul>

<hr>

<h2 id="estratégia-de-solução">Estratégia de Solução</h2>

<h3 id="passo-1-resumir-o-contexto-em-uma-pergunta-aberta">Passo 1: Pergunta Aberta</h3>
<ul>
  <li><strong>Área Comercial:</strong> Como aumentar o volume de vendas e a rentabilidade do marketplace?</li>
  <li><strong>Área de Marketing:</strong> Como ampliar a retenção e o LTV (valor vitalício) do cliente?</li>
  <li><strong>Área Operacional:</strong> Como tornar as entregas mais eficientes, reduzindo atrasos e custos?</li>
</ul>

<h3 id="passo-2-transformar-uma-pergunta-aberta-em-uma-pergunta-fechada">Passo 2: Pergunta Fechada</h3>
<ul>
  <li><strong>Comercial:</strong> Quais vendedores, categorias e regiões mais contribuem para o aumento do GMV e rentabilidade?</li>
  <li><strong>Marketing:</strong> Quais características e comportamentos distinguem os clientes com maior LTV e probabilidade de recompra?</li>
  <li><strong>Operacional:</strong> Quais fatores mais influenciam o tempo médio de entrega e a taxa de atraso?</li>
</ul>

<h3 id="passo-3-definição-do-fato">Passo 3: Definição do Fato</h3>
<ul>
  <li><strong>Comercial:</strong> GMV (Gross Merchandise Volume) — faturamento bruto do marketplace.</li>
  <a href="Documentação Técnica-Área Comercial.md" target="_blank" rel="noopener noreferrer">Documentação Técnica Analítica - Área Comercial</a>
  <li><strong>Marketing:</strong> LTV (Lifetime Value) — valor total gerado por cliente ao longo do tempo.</li> 
  <a href="Documentação Técnica-Marketing.md" target="_blank" rel="noopener noreferrer">Documentação Técnica Analítica - Área de Marketing</a>
  <li><strong>Operacional:</strong> TME (Tempo Médio de Entrega) — tempo médio entre aprovação e entrega do pedido.</li> 
  <a href="Documentação Head-de-Operações.md" target="_blank" rel="noopener noreferrer">Documentação Técnica Analítica - Área Operacional</a>
</ul>

<hr>

<h3 id="passo-4-identificação-das-dimensões">Passo 4: Identificação das Dimensões</h3>
<ul>
<li><strong>Comercial:</strong> Vendedor, Categoria de Produto, Região, Tempo, Canal de Venda.</li>
<li><strong>Marketing:</strong> Segmento RFM, Categoria de Primeira Compra, Estado, Faixa Etária, Avaliação, Recência.</li>
<li><strong>Operacional:</strong> Vendedor, Região de Destino, Categoria, Peso, Transportadora, Data da Compra.</li>
</ul>

<h3 id="passo-5-hipóteses-analíticas">Passo 5: Hipóteses Analíticas</h3>
<p>As hipóteses analíticas combinam Fato + Dimensão + Comparação e orientam a exploração dos dados.</p>

<h4>Área Comercial</h4>
<ul>
  <li>O GMV dos vendedores do Sudeste é maior que o das outras regiões.</li>
  <li>Categorias de alto valor agregado geram maior GMV por pedido.</li>
  <li>Vendedores com menor taxa de cancelamento têm maior rentabilidade.</li>
  <li>O GMV cresce mês a mês.</li>
</ul>

<h4>Área de Marketing</h4>
<ul>
  <li>Clientes “Campeões” no modelo RFM possuem LTV maior que outros segmentos.</li>
  <li>A categoria da primeira compra influencia o LTV médio.</li>
  <li>Clientes com boas avaliações têm maior taxa de recompra.</li>
</ul>

<h4>Área Operacional</h4>
<ul>
  <li>O TME é maior nas regiões Norte e Nordeste.</li>
  <li>Produtos mais pesados elevam o TME médio.</li>
  <li>Transportadoras específicas apresentam melhor desempenho.</li>
</ul>

<hr>

<h3 id="passo-6-critérios-de-priorização">Passo 6: Critérios de Priorização</h3>
<ol>
  <li><strong>Disponibilidade dos Dados:</strong> Existem dados suficientes e confiáveis?</li>
  <li><strong>Insight Acionável:</strong> O resultado gera uma ação prática?</li>
  <li><strong>Facilidade de Implementação:</strong> É simples executar a análise?</li>
  <li><strong>Impacto no Negócio:</strong> O resultado traz impacto financeiro ou estratégico?</li>
</ol>

<h3 id="passo-7-priorização-das-hipóteses">Passo 7: Priorização das Hipóteses</h3>
<ul>
  <li><strong>Comercial:</strong> GMV por Região e Categoria (alta prioridade)</li>
  <li><strong>Marketing:</strong> LTV por Segmento RFM e Categoria de Primeira Compra</li>
  <li><strong>Operacional:</strong> TME por Região e Peso/Dimensão</li>
</ul>

<hr>

<h2 id="modelagem-de-dados-schema-estrela">Modelagem de Dados (Schema Estrela)</h2>
<p><strong>Objetivo:</strong> Estruturar os dados em um modelo analítico (Data Mart) que suporte decisões estratégicas de cada área.</p>

<table>
  <thead>
    <tr>
      <th>Tabela Fato</th>
      <th>Métrica Principal</th>
      <th>Métricas Complementares</th>
      <th>Dimensões Relacionadas</th>
      <th>Objetivo Analítico</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>FATO_COMERCIAL</td><td>GMV</td><td>Ticket Médio, Volume de Pedidos, Receita</td><td>TEMPO, PRODUTO, VENDEDOR, CLIENTE</td><td>Mensurar performance e rentabilidade do marketplace.</td></tr>
    <tr><td>FATO_CLIENTE</td><td>LTV</td><td>Recorrência, Frequência de Compra, Score RFM</td><td>CLIENTE, TEMPO, PRODUTO</td><td>Medir valor e fidelização de clientes.</td></tr>
    <tr><td>FATO_OPERACIONAL</td><td>TME</td><td>Taxa de Entrega no Prazo, Custo Frete</td><td>TEMPO, VENDEDOR, GEOGRAFIA</td><td>Monitorar eficiência logística e atrasos.</td></tr>
  </tbody>
</table>

<hr>

<h2 id="estrutura-dos-dashboards">Estrutura dos Dashboards</h2>

<h3>Comercial</h3>
<ul>
  <li>Cards: GMV, Ticket Médio, Volume de Pedidos</li>
  <li>Top 5 Vendedores e Categorias</li>
  <li>Evolução mensal: GMV mês a mês</li>
  <li>Receita por Categoria</li>
</ul>
<p><a href="https://lookerstudio.google.com/u/0/reporting/comercial-dashboard" target="_blank" rel="noopener noreferrer">Dashboard Comercial no Looker Studio</a></p>

<h3>Marketing/Clientes</h3>
<ul>
  <li>Indicadores: LTV, Taxa de Recorrência</li>
  <li>Segmentação RFM</li>
  <li>Categoria de Primeira Compra</li>
  <li>Taxa de Avaliações Negativas</li>
</ul>
<p><a href="https://lookerstudio.google.com/u/0/reporting/marketing-dashboard" target="_blank" rel="noopener noreferrer">Dashboard Marketing no Looker Studio</a></p>

<h3>Operacional</h3>
<ul>
  <li>Indicadores: TME, SLA Vendedores, Entrega no Prazo</li>
  <li>Top 5 Cidades e Vendedores com Atraso</li>
  <li>Custo do Frete por Dimensão</li>
  <li>Frete vs. Peso/Comprimento</li>
</ul>
<p><a href="https://lookerstudio.google.com/u/0/reporting/operacoes-dashboard" target="_blank" rel="noopener noreferrer">Dashboard Operacional no Looker Studio</a></p>
<hr>

<h2 id="tecnologias-utilizadas">Tecnologias Utilizadas</h2>
<ul>
  <li>Google BigQuery (SQL)</li>
  <li>Looker Studio</li>
  <li>Google Sheets</li>
  <li>Metodologia CRISP-DM</li>
</ul>

<hr>

<h2 id="lições-aprendidas">Lições Aprendidas</h2>
<ul>
  <li>A importância de começar a análise pelo <strong>entendimento de negócio</strong>, não pelos dados.</li>
  <li>Como a estrutura Fato-Dimensão facilita escalabilidade e manutenção.</li>
  <li>Testar hipóteses simples antes de análises complexas.</li>
  <li>Validar continuamente com stakeholders.</li>
  <li>Equilibrar clareza visual e profundidade analítica nos dashboards.</li>
</ul>


