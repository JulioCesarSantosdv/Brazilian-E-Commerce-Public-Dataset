<h1>DASHBOARDS ESTRATÉGICOS PARA O E-COMMERCE OLIST: VISÃO 360° DA PERFORMANCE COMERCIAL, CLIENTES E OPERAÇÕES</h1>

<h2> Visão Geral do Projeto</h2>
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
  <li><strong>Entendimento do Negócio</strong> – Levantamento de requisitos com stakeholders</li>
  <li><strong>Entendimento dos Dados</strong> – Análise dos datasets da Olist</li>
  <li><strong>Preparação dos Dados</strong> – Modelagem e transformação</li>
  <li><strong>Modelagem</strong> – Criação do schema analítico</li>
  <li><strong>Avaliação</strong> – Validação com stakeholders</li>
  <li><strong>Implantação</strong> – Dashboards no Looker Studio</li>
</ul>

<h3>Técnicas de Levantamento de Requisitos</h3>
<p>Utilizamos uma abordagem mista para garantir alinhamento total com as necessidades de negócio:</p>

<p> <strong>Perguntas Abertas:</strong></p>
<ul>
  <li>"Qual é seu objetivo principal com este dashboard?"</li>
  <li>"Quais são suas maiores dores atualmente?"</li>
</ul>

<p> <strong>Perguntas Fechadas:</strong></p>
<ul>
  <li>"O KPI de LTV atende sua necessidade?"</li>
  <li>"A dimensão por categoria de produto é essencial?"</li>
</ul>

<h3> Hipóteses de Negócio Validadas:</h3>
<ul>
  <li>"Clientes que compram eletrônicos têm maior LTV"</li>
  <li>"Vendedores com menor tempo de preparação têm maior taxa de entrega no prazo"</li>
  <li>"Avaliações negativas estão correlacionadas com atrasos na entrega"</li>
</ul>

<h2>Levantamento de Requisitos por Área</h2>

<h3>Área Comercial (Diretor Comercial)</h3>
<p><strong>Objetivo:</strong> Maximizar o GMV e a rentabilidade do marketplace</p>


<p><strong>Dimensões de Análise:</strong> Categoria de Produto, Estado do Cliente, Período (Mês/Ano)</p>
<p> <a href="https://github.com/JulioCesarSantosdv/Brazilian-E-Commerce-Public-Dataset/blob/main/Documenta%C3%A7%C3%A3o%20T%C3%A9cnica-%C3%81rea%20Comercial.md">Documentação Técnica - Área Comercial</a></p>
<hr>

<h3>Área de Marketing (Gerente de Marketing)</h3>
<p><strong>Objetivo:</strong> Entender perfil do cliente e eficácia das campanhas</p>

<p><strong>Dimensões de Análise:</strong> Segmento RFM, Categoria de Produto, Estado do Cliente</p>
<p>
  <a href="https://github.com/JulioCesarSantosdv/Brazilian-E-Commerce-Public-Dataset/blob/main/Documenta%C3%A7%C3%A3o%20T%C3%A9cnica-Marketing.md"
     target="_blank"
     rel="noopener noreferrer">
     Documentação Técnica - Área de Marketing
  </a>
</p>
<hr>

<h3>Área Operacional (Head de Operações)</h3>
<p><strong>Objetivo:</strong> Garantir eficiência logística e qualidade da entrega</p>

<p><strong>Dimensões de Análise:</strong> Vendedor, Região de Destino, Categoria de Produto</p>

<p><a href="https://github.com/JulioCesarSantosdv/Brazilian-E-Commerce-Public-Dataset/blob/main/Documenta%C3%A7%C3%A3o%20Head-de-Opera%C3%A7%C3%B5es.md"_blank">Documentação Técnica - Área Operacional</a></p>

<hr>

<h2>Modelagem de Dados (Schema Star)</h2>
<h3>Estrutura do Data Mart</h3>

<h4>Tabelas Fato</h4>
<table>
  <thead>
    <tr>
      <th>Tabela Fato</th>
      <th>Foco</th>
      <th>Métricas Principais</th>
      <th>Dimensões Relacionadas</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>FATO_COMERCIAL</td><td>Transações de venda</td><td>GMV, Ticket Médio, Receita</td><td>TEMPO, PRODUTO, VENDEDOR, CLIENTE</td></tr>
    <tr><td>FATO_CLIENTES</td><td>Comportamento do cliente</td><td>LTV, Recorrência, Score RFM</td><td>CLIENTE, TEMPO, PRODUTO</td></tr>
    <tr><td>FATO_OPERACIONAL</td><td>Logística e entrega</td><td>TME, Taxa de Entrega, Custo Frete</td><td>TEMPO, VENDEDOR, GEOGRAFIA</td></tr>
  </tbody>
</table>

<h4>Tabelas Dimensão</h4>
<table>
  <thead>
    <tr>
      <th>Dimensão</th>
      <th>Descrição</th>
      <th>Campos Principais</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>DIM_TEMPO</td><td>Datas para análise temporal</td><td>data_key, ano, mês, trimestre, dia_semana</td></tr>
    <tr><td>DIM_CLIENTE</td><td>Dados demográficos e geográficos</td><td>customer_id, estado, cidade, segmento_rfm</td></tr>
    <tr><td>DIM_VENDEDOR</td><td>Dados dos vendedores parceiros</td><td>seller_id, cidade, estado</td></tr>
    <tr><td>DIM_PRODUTO</td><td>Características dos produtos</td><td>product_id, categoria, peso, comprimento</td></tr>
    <tr><td>DIM_GEOGRAFIA</td><td>Dados geográficos para análise espacial</td><td>geolocation_zip_code, cidade, estado, coordenadas</td></tr>
  </tbody>
</table>

<hr>

<h2>Estrutura dos Dashboards (Looker Studio)</h2>

<h3>Visão Executiva (C-Level)</h3>
<ul>
  <li>KPIs agregados das 3 áreas</li>
  <li>Gráfico de tendência: Receita vs. Entrega no Prazo</li>
  <li>Mapa geográfico: Heatmap de vendas e atrasos</li>
  <li>Alertas: Indicadores críticos (inadimplência, avaliações negativas)</li>
</ul>
<p><a href="https://lookerstudio.google.com/u/0/reporting/operacoes-dashboard" target="_blank">Dashboard Executivo no Looker Studio</a></p>

<h3>Visão Comercial</h3>
<ul>
  <li>Cards de performance: GMV, Ticket Médio, Volume de Pedidos</li>
  <li>Rankings: Top 5 Vendedores e Categorias</li>
  <li>Evolução temporal: Variação do GMV mês a mês</li>
  <li>Análise de portfólio: Receita por Categoria</li>
</ul>
<p> <a href="https://lookerstudio.google.com/u/0/reporting/comercial-dashboard" target="_blank">Dashboard Comercial no Looker Studio</a></p>

<h3>Visão Marketing/Clientes</h3>
<ul>
  <li>Indicadores de retenção: LTV, Taxa de Recorrência</li>
  <li>Segmentação RFM: Distribuição de clientes (Campeões, Em Risco, etc.)</li>
  <li>Análise de aquisição: Categoria de Primeira Compra</li>
  <li>Satisfação: Taxa de Avaliações Negativas e Tempo Médio de Avaliação</li>
</ul>
<p> <a href="https://lookerstudio.google.com/u/0/reporting/comercial-dashboard" target="_blank">Dashboard Marketing no Looker Studio</a></p>

<h3> Visão Operacional</h3>
<ul>
  <li>Indicadores logísticos: TME, Taxa de Entrega no Prazo, SLA Vendedores</li>
  <li>Análise de risco: Top 5 Cidades e Vendedores com maior taxa de atraso</li>
  <li>Otimização de custos: Custo do Frete por Dimensão do Produto</li>
  <li>Gráfico de dispersão: Frete vs. Peso/Comprimento</li>
</ul>
<p><a href="https://lookerstudio.google.com/u/0/reporting/operacoes-dashboard" target="_blank">Dashboard Operacional no Looker Studio</a></p>
