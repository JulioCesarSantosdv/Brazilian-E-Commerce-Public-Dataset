<h1>DASHBOARDS ESTRATÉGICOS PARA O E-COMMERCE OLIST: VISÃO 360° DA PERFORMANCE COMERCIAL, CLIENTES E OPERAÇÕES</h1>
<hr>

## Sumário
- [Visão Geral do Projeto](#visão-geral-do-projeto)
- [Metodologia e Abordagem](#metodologia-e-abordagem)
- [Estratégia de Solução](#estratégia-de-solução)
  - [Passo 1: Pergunta Aberta](#passo-1-resumir-o-contexto-em-uma-pergunta-aberta)
  - [Passo 2: Pergunta Fechada](#passo-2-transformar-uma-pergunta-aberta-em-uma-pergunta-fechada)
  - [Passo 3: Definição do Fato](#passo-3-definição-do-fato)
  - [Passo 4: Identificação das Dimensões](#passo-4-identificação-das-dimensões)
  - [Passo 5: Hipóteses Analíticas](#passo-5-hipóteses-analíticas)
  - [Passo 6: Critérios de Priorização](#passo-6-critérios-de-priorização)
  - [Passo 7: Priorização das Hipóteses](#passo-7-priorização-das-hipóteses)
- [Estrutura dos Dashboards](#estrutura-dos-dashboards)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
<hr>

<h2>Visão Geral do Projeto</h2>
<p>
Este projeto consiste na construção de uma suíte de dashboards analíticos no Looker Studio para fornecer uma visão 360° da operação do e-commerce Olist. 
O objetivo é transformar dados brutos em insights estratégicos acionáveis para diferentes stakeholders, simulando um ciclo completo de análise de dados seguindo a metodologia <strong>CRISP-DM</strong>.
</p>
<p>
A solução abrange três pilares estratégicos: <strong>Performance Comercial</strong>, <strong>Comportamento do Cliente</strong> e <strong>Eficiência Operacional</strong>, 
atendendo às necessidades do Diretor Comercial, Gerente de Marketing e Head de Operações.
</p>

<hr>

<h2>Metodologia e Abordagem</h2>

<h3>CRISP-DM Aplicado</h3>
<p>O projeto segue as seis fases da metodologia CRISP-DM:</p>
<ul>
  <li><strong>Entendimento do Negócio</strong> – Levantamento de requisitos com stakeholders;</li>
  <li><strong>Entendimento dos Dados</strong> – Análise dos datasets da Olist;</li>
  <li><strong>Preparação dos Dados</strong> – Modelagem e transformação;</li>
  <li><strong>Modelagem</strong> – Criação do schema analítico;</li>
  <li><strong>Avaliação</strong> – Validação com stakeholders;</li>
  <li><strong>Implantação</strong> – Dashboards no Looker Studio.</li>
</ul>

<hr>

<h2>Estratégia de Solução</h2>

<h3>Passo 1: Resumir o contexto em uma pergunta aberta</h3>
<p>
As perguntas abertas representam problemas estratégicos amplos e exploratórios, geralmente começando com “Como” ou “Por que”.  
Foram definidas as seguintes:
</p>
<ul>
  <li><strong>Área Comercial:</strong> Como aumentar o volume de vendas e a rentabilidade do marketplace?</li>
  <li><strong>Área de Marketing:</strong> Como ampliar a retenção e o LTV (valor vitalício) do cliente?</li>
  <li><strong>Área Operacional:</strong> Como tornar as entregas mais eficientes, reduzindo atrasos e custos?</li>
</ul>

<h3>Passo 2: Transformar uma pergunta aberta em uma pergunta fechada</h3>
<p>
As perguntas fechadas direcionam a análise para o que precisa ser mensurado e respondido com dados.  
Geralmente começam com “Quais”, “Quanto” ou “Quem”.
</p>
<ul>
  <li><strong>Área Comercial:</strong> Quais vendedores, categorias e regiões mais contribuem para o aumento do GMV e rentabilidade?</li>
  <li><strong>Área de Marketing:</strong> Quais características e comportamentos distinguem os clientes com maior LTV e probabilidade de recompra?</li>
  <li><strong>Área Operacional:</strong> Quais fatores mais influenciam o tempo médio de entrega e a taxa de atraso?</li>
</ul>

<h3>Passo 3: Definição do Fato</h3>
<p>
O <strong>Fato</strong> é a métrica central da análise , é o ponto que conecta a pergunta fechada à forma de mensurar os resultados.
</p>

<ul>
  <li><strong>Área Comercial:</strong> GMV (Gross Merchandise Volume) — representa o faturamento bruto do marketplace.</li>
  <li><strong>Área de Marketing:</strong> LTV (Lifetime Value) — mede o valor total gerado por cliente ao longo do tempo.</li>
  <li><strong>Área Operacional:</strong> TME (Tempo Médio de Entrega) — mede o tempo, em dias, entre a aprovação e a entrega do pedido.</li>
</ul>

<hr>

<h3>Passo 4: Identificação das Dimensões</h3>
<p>
As <strong>Dimensões</strong> explicam o Fato e permitem segmentar e detalhar os resultados.
</p>

<ul>
  <li><strong>Comercial:</strong> Vendedor, Categoria de Produto, Região, Tempo, Canal de Venda.</li>
  <li><strong>Marketing:</strong> Segmento RFM, Categoria de Primeira Compra, Estado, Faixa Etária, Avaliação, Recência.</li>
  <li><strong>Operacional:</strong> Vendedor, Região de Destino, Categoria de Produto, Peso/Dimensões, Transportadora, Data da Compra.</li>
</ul>

<hr>

<h3>Passo 5: Hipóteses Analíticas</h3>
<p>
As <strong>Hipóteses Analíticas</strong> combinam Fato + Dimensão + Comparação.  
São investigações quantitativas que direcionam a exploração dos dados e a geração de insights.
</p>

<h4>Área Comercial</h4>
<ul>
  <li>O GMV dos vendedores do Sudeste é maior que o das outras regiões.</li>
  <li>Categorias de alto valor agregado geram maior GMV por pedido.</li>
  <li>Vendedores com menor taxa de cancelamento têm maior rentabilidade.</li>
  <li>O GMV cresce mês a mês no período analisado.</li>
</ul>
<p><a href="Documentação Técnica-Área Comercial.md" target="_blank" rel="noopener noreferrer">Documentação Técnica Analítica - Área Comercial</a></p>

<h4>Área de Marketing</h4>
<ul>
  <li>Clientes “Campeões” no modelo RFM possuem LTV maior que outros segmentos.</li>
  <li>A categoria da primeira compra influencia o LTV médio.</li>
  <li>Clientes com boas avaliações têm maior taxa de recompra.</li>
</ul>
<p><a href="Documentação Técnica-Marketing.md" target="_blank" rel="noopener noreferrer">Documentação Técnica Analítica - Área de Marketing</a></p>

<h4>Área Operacional</h4>
<ul>
  <li>O TME é maior nas regiões Norte e Nordeste.</li>
  <li>Produtos mais pesados ou volumosos elevam o TME médio.</li>
  <li>Transportadoras específicas apresentam melhor desempenho.</li>
</ul>
<p><a href="Documentação Head-de-Operações.md" target="_blank" rel="noopener noreferrer">Documentação Técnica Analítica - Área Operacional</a></p>

<hr>

<h3>Passo 6: Critérios de Priorização</h3>
<p>As hipóteses são priorizadas com base em quatro critérios principais:</p>
<ol>
  <li><strong>Disponibilidade dos Dados:</strong> Existem dados suficientes e confiáveis?</li>
  <li><strong>Insight Acionável:</strong> O resultado gera uma ação prática?</li>
  <li><strong>Facilidade de Implementação:</strong> É simples executar a análise?</li>
  <li><strong>Impacto no Negócio:</strong> O resultado traz impacto financeiro ou estratégico?</li>
</ol>

<hr>

<h3>Passo 7: Priorização das Hipóteses</h3>
<p>
Após avaliar os critérios, as hipóteses mais relevantes são priorizadas:
</p>

<h4>Comercial</h4>
<ul>
  <li><strong>Alta prioridade:</strong> GMV por Região e por Categoria — impacto direto nas vendas.</li>
</ul>

<h4>Marketing</h4>
<ul>
  <li><strong>Alta prioridade:</strong> LTV por Segmento RFM e Categoria de Primeira Compra — fundamentais para retenção.</li>
</ul>

<h4>Operacional</h4>
<ul>
  <li><strong>Alta prioridade:</strong> TME por Região e Peso/Dimensão — essenciais para otimização logística.</li>
</ul>

<p><em>Essas hipóteses guiam as análises e sustentam as decisões estratégicas de cada área.</em></p>

<hr>

<h2>Estrutura dos Dashboards </h2>

<h3>Visão Comercial</h3>
<ul>
  <li>Cards: GMV, Ticket Médio, Volume de Pedidos</li>
  <li>Top 5 Vendedores e Categorias</li>
  <li>Evolução temporal: GMV mês a mês</li>
  <li>Receita por Categoria</li>
</ul>
<p><a href="https://lookerstudio.google.com/u/0/reporting/comercial-dashboard" target="_blank" rel="noopener noreferrer">Dashboard Comercial no Looker Studio</a></p>

<h3>Visão Marketing/Clientes</h3>
<ul>
  <li>Indicadores: LTV, Taxa de Recorrência</li>
  <li>Segmentação RFM</li>
  <li>Categoria de Primeira Compra</li>
  <li>Taxa de Avaliações Negativas</li>
</ul>
<p><a href="https://lookerstudio.google.com/u/0/reporting/marketing-dashboard" target="_blank" rel="noopener noreferrer">Dashboard Marketing no Looker Studio</a></p>

<h3>Visão Operacional</h3>
<ul>
  <li>Indicadores: TME, SLA Vendedores, Taxa de Entrega no Prazo</li>
  <li>Top 5 Cidades e Vendedores com Atraso</li>
  <li>Custo do Frete por Dimensão do Produto</li>
  <li>Frete vs. Peso/Comprimento</li>
</ul>
<p><a href="https://lookerstudio.google.com/u/0/reporting/operacoes-dashboard" target="_blank" rel="noopener noreferrer">Dashboard Operacional no Looker Studio</a></p>

<hr>

<h2>Tecnologias Utilizadas </h2>
<ul>
  <li>BigQuery / SQL</li>
  <li>Looker Studio</li>
  <li>Google Sheets</li>
  <li>Metodologia CRISP-DM</li>
</ul>

