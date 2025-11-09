<h1>ANÁLISE DE DADOS OLIST E-COMMERCE</h1>
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

<h2>Visão Geral do Projeto</h2>

<p>
Este projeto simula um <strong>cenário realista da rotina de um analista de dados</strong> em uma empresa de e-commerce. 
O objetivo é representar todas as etapas do processo analítico — desde o <strong>levantamento de requisitos com stakeholders</strong>, 
passando pela <strong>modelagem e exploração dos dados (SQL)</strong>, até a <strong>construção de dashboards estratégicos no Looker Studio</strong>.

<strong>Dataset utilizado: </strong><a href="https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce" target="_blank" rel="noopener noreferrer">Brazilian E-Commerce Public Dataset by Olist</a>
</p>

<hr>

<h2 id="metodologia-e-abordagem">Metodologia e Abordagem</h2>

<p>
Para este projeto foi adotada a metodologia <strong>CRISP-DM (Cross Industry Standard Process for Data Mining)</strong>, 
estruturada para conduzir projetos de análise de dados. 
Ela divide o processo analítico em <strong>seis fases cíclicas</strong>, permitindo ir da compreensão do negócio até a entrega de valor.
</p>

<p><strong>Etapas principais:</strong></p>
<ul>
  <li><strong>Entendimento do Negócio</strong> — definir objetivos e requisitos estratégicos.</li>
  <li><strong>Entendimento dos Dados</strong> — coletar, explorar e avaliar a qualidade dos dados.</li>
  <li><strong>Preparação dos Dados</strong> — limpar, transformar e integrar as fontes.</li>
  <li><strong>Modelagem</strong> — criar e testar estruturas analíticas ou preditivas.</li>
  <li><strong>Avaliação</strong> — validar resultados com base nos objetivos de negócio.</li>
  <li><strong>Implantação</strong> — disponibilizar os resultados (dashboards, relatórios ou modelos).</li>
</ul>

<p><em>Em suma:</em> o CRISP-DM garante que a análise de dados seja <strong>guiada pelo negócio</strong>, 
<strong>tecnicamente sólida</strong> e <strong>voltada à tomada de decisão</strong>.</p>


<hr>

<h2 id="estratégia-de-solução">Estratégia de Solução</h2>

<h3 id="passo-1-resumir-o-contexto-em-uma-pergunta-aberta">Passo 1: Resumir o contexto em uma Pergunta Aberta</h3>
<p>
As perguntas abertas definem o problema estratégico de forma ampla, guiando o direcionamento da análise.
</p>
<ul>
  <li><strong>Área Comercial:</strong> Como aumentar o volume de vendas e a rentabilidade do marketplace?</li>
  <li><strong>Área de Marketing:</strong> Como ampliar a retenção e o LTV (valor vitalício) do cliente?</li>
  <li><strong>Área Operacional:</strong> Como tornar as entregas mais eficientes, reduzindo atrasos e custos?</li>
</ul>

<h3 id="passo-2-transformar-uma-pergunta-aberta-em-uma-pergunta-fechada">Passo 2: Transformar uma pergunta aberta em um pergunta fechada</h3>
<p>
As perguntas fechadas transformam o problema estratégico em algo mensurável e objetivo, eis aqui o ponto de partida da análise quantitativa.
</p>
<ul>
  <li><strong>Comercial:</strong> Quais vendedores, categorias e regiões mais contribuem para o aumento do GMV e rentabilidade?</li>
  <li><strong>Marketing:</strong> Quais características e comportamentos distinguem os clientes com maior LTV e probabilidade de recompra?</li>
  <li><strong>Operacional:</strong> Quais fatores mais influenciam o tempo médio de entrega e a taxa de atraso?</li>
</ul>

<h3 id="passo-3-definição-do-fato">Passo 3: Definição do Fato</h3>
<p>
O <strong>Fato</strong> é a métrica principal que traduz o objetivo de negócio em um indicador quantificável.  
Cada área de análise possui um Fato diferente, conforme sua natureza e foco estratégico:
</p>
<ul>
  <li>
    <strong>Comercial:</strong> <em>GMV (Gross Merchandise Volume)</em> — representa o valor bruto pago pelo cliente  (incluindo o preço do produto, frete e impostos), refletindo o desempenho financeiro das vendas.
    <br>
    <a href="Documentação Técnica-Área Comercial.md" target="_blank" rel="noopener noreferrer">Levantamento de Requisitos - Área Comercial</a>
  </li>

  <li>
    <strong>Marketing:</strong> <em>LTV (Lifetime Value)</em> — indica o valor total que um cliente gera ao longo de seu relacionamento com a empresa, refletindo retenção e fidelização.
    <br>
    <a href="Documentação Técnica-Marketing.md" target="_blank" rel="noopener noreferrer">Levantamento de Requisitos - Área de Marketing</a>
  </li>

  <li>
    <strong>Operacional:</strong> <em>TME (Tempo Médio de Entrega)</em> — mede a média de dias entre a aprovação do pedido e sua entrega ao cliente, refletindo a eficiência logística.
    <br>
    <a href="Documentação Head-de-Operações.md" target="_blank" rel="noopener noreferrer">Levantamento de Requisitos - Área Operacional</a>
  </li>
</ul>
<hr>

<h3 id="passo-4-identificação-das-dimensões">Passo 4: Identificação das Dimensões</h3>
<p>
As <strong>Dimensões</strong> são os atributos que explicam o <em>Fato</em>, permitindo segmentar, detalhar e comparar os resultados.  
Enquanto o Fato responde <strong>“o que está acontecendo”</strong>, as dimensões ajudam a entender <strong>“por que e com quem isso acontece”</strong>.
</p>

<ul>
  <li>
    <strong>Comercial:</strong> 
    Vendedor, Categoria de Produto, Região, Tempo, Canal de Venda.  
    <br>
    <em>Essas dimensões permitem analisar o desempenho comercial sob diferentes perspectivas: como produtos mais rentáveis, vendedores de destaque e variações regionais de vendas.</em>
  </li>

  <li>
    <strong>Marketing:</strong> 
    Segmento RFM, Categoria de Primeira Compra, Estado, Faixa Etária, Avaliação, Recência.  
    <br>
    <em>Essas dimensões possibilitam identificar perfis de clientes com maior valor de vida (LTV), padrões de recompra e fatores de satisfação ou retenção.</em>
  </li>

  <li>
    <strong>Operacional:</strong> 
    Vendedor, Região de Destino, Categoria de Produto, Peso, Transportadora, Data da Compra.  
    <br>
    <em>Essas dimensões ajudam a compreender variações logísticas, prazos de entrega e gargalos operacionais relacionados a produtos ou regiões.</em>
  </li>
</ul>

<hr>

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
<p>
Nem todas as hipóteses devem ser testadas de imediato.  
Os <strong>critérios de priorização</strong> ajudam o analista a focar no que tem maior potencial de impacto com o menor esforço possível.
</p>

<ol>
  <li><strong>Disponibilidade dos Dados:</strong> Existem dados suficientes e confiáveis para validar a hipótese?</li>
  <li><strong>Insight Acionável:</strong> O resultado pode gerar uma ação prática ou decisão estratégica?</li>
  <li><strong>Facilidade de Implementação:</strong> A análise é tecnicamente simples de executar?</li>
  <li><strong>Impacto no Negócio:</strong> O resultado tem potencial de gerar retorno financeiro, operacional ou estratégico?</li>
</ol>

<hr>

<h3 id="passo-7-priorização-das-hipóteses">Passo 7: Priorização das Hipóteses</h3>
<p>
Após aplicar os critérios anteriores, são priorizadas as hipóteses com maior valor analítico e impacto no negócio:
</p>

<ul>
  <li><strong>Comercial:</strong> GMV por Região e Categoria — <em>alta prioridade (impacto direto em vendas e rentabilidade).</em></li>
  <li><strong>Marketing:</strong> LTV por Segmento RFM e Categoria de Primeira Compra — <em>prioridade alta (apoia estratégias de retenção e fidelização).</em></li>
  <li><strong>Operacional:</strong> TME por Região e Peso/Dimensão — <em>prioridade alta (otimização logística e redução de custos).</em></li>
</ul>

<p><em>Essas hipóteses guiam as análises e sustentam as decisões estratégicas de cada área de negócio.</em></p>

<hr>

<h2 id="modelagem-de-dados-schema-estrela">Modelagem de Dados (Schema Estrela)</h2>
<p>
<strong>Objetivo:</strong> Estruturar os dados em um modelo analítico (Data Mart) que suporte decisões estratégicas de cada área, utilizando uma única Tabela Fato central, a <strong>FATO_PEDIDO</strong>, na granularidade de <strong>Item de Pedido</strong>. Essa abordagem simula um cenário real de e-commerce, otimizando a consulta e reduzindo a redundância de dados.
</p>

<table>
  <thead>
    <tr>
      <th>Tabela Fato</th>
      <th>Granularidade</th>
      <th>Métricas (Fatos)</th>
      <th>Dimensões Relacionadas</th>
      <th>Objetivo Analítico</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>FATO_PEDIDO</strong></td>
      <td>Item de Pedido (<code>order_item_id</code>)</td>
      <td>GMV (<code>price</code> + <code>freight_value</code>), Datas de Entrega (para TME), Valor do Pagamento (<code>payment_value</code>)</td>
      <td>DIM_TEMPO, DIM_PRODUTO, DIM_VENDEDOR, DIM_CLIENTE, DIM_GEOGRAFIA</td>
      <td>Mensurar performance comercial, eficiência operacional e fornecer a base para o cálculo do LTV (Marketing).</td>
    </tr>
  </tbody>
</table>

<p>
A partir da <strong>FATO_PEDIDO</strong>, as análises para as três áreas são realizadas:
</p>
<ul>
  <li><strong>Comercial:</strong> Consulta direta ao GMV e agregações por Vendedor e Produto.</li>
  <li><strong>Operacional:</strong> Consulta direta às datas de <strong>timestamp</strong> para cálculo do TME e análise de frete.</li>
  <li><strong>Marketing/Cliente:</strong> O LTV é calculado por agregação do GMV ao longo do tempo, utilizando a chave única do cliente (<code>customer_unique_id</code>) presente na FATO_PEDIDO e detalhada na DIM_CLIENTE.</li>
</ul>

<hr>

<h2 id="estrutura-dos-dashboards">Estrutura dos Dashboards</h2>

<h3>Comercial</h3>
<ul>
  <li>Cards: GMV, Ticket Médio, Volume de Pedidos</li>
  <li>Top 5 Vendedores e Categorias</li>
  <li>Evolução mensal: GMV mês a mês</li>
  <li>Receita por Categoria</li>
</ul>
<p><a href="https://lookerstudio.google.com/reporting/c45588de-9a47-4d9a-b24b-eb40422bf5f1" target="_blank" rel="noopener noreferrer">Dashboard Comercial no Looker Studio</a></p>

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
