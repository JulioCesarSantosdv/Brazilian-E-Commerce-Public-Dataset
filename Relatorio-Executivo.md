<h1>Relatório Executivo — Investigação Olist: Análise de Churn e Retenção</h1>

<h2>Contexto e Objetivo da Investigação</h2>
<p>O objetivo principal desta análise foi identificar as causas raiz da <strong>baixa retenção de clientes</strong> na Olist e propor soluções baseadas em dados para <strong>aumentar a fidelidade</strong> e o valor de vida (LTV) dos consumidores.</p>

<hr>

<h2>Resumo Executivo</h2>
<p><strong>Status Atual:</strong> Crítico — Apenas <strong>3,05% dos clientes retornam</strong> para uma segunda compra.</p>

<div style="background: #ff6b6b; color: white; padding: 10px; border-radius: 8px;">
⚠️ Alerta: A taxa de recompra é extremamente baixa, impactando diretamente o crescimento sustentável.
</div>

<hr>

<h2>Metodologia e Estrutura da Análise</h2>
<p>A investigação foi conduzida em três fases principais, utilizando <strong>consultas SQL no BigQuery</strong> e dashboards de apoio no <strong>Looker Studio</strong>.</p>

<table>
  <thead>
    <tr>
      <th>Fase</th>
      <th>Objetivo</th>
      <th>Consultas SQL</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Diagnóstico</strong></td>
      <td>Entender a magnitude do problema</td>
      <td>6 consultas</td>
    </tr>
    <tr>
      <td><strong>Análise</strong></td>
      <td>Identificar padrões e correlações</td>
      <td>9 consultas</td>
    </tr>
    <tr>
      <td><strong>Soluções</strong></td>
      <td>Propor ações específicas</td>
      <td>Relatório executivo</td>
    </tr>
  </tbody>
</table>

<hr>

<h2>Principais Descobertas</h2>

<h3>1. Problema de Churn Crítico</h3>
<p>Dos 95.420 clientes únicos analisados:</p>
<ul>
  <li><strong>Única Compra:</strong> 92.507 clientes (96,95%)</li>
  <li><strong>Recorrentes:</strong> 2.913 clientes (3,05%)</li>
</ul>

<h3>2. Clientes de Alto Valor Perdidos</h3>
<ul>
  <li><strong>Alto Valor + Única Compra:</strong> 1.244 clientes — oportunidade desperdiçada.</li>
  <li><strong>Alto Valor + Frequente:</strong> apenas 12 clientes — os “Campeões”.</li>
</ul>

<h3>3. Disparidade Regional</h3>
<table>
  <thead>
    <tr>
      <th>Estado</th>
      <th>TME (dias)</th>
      <th>Taxa de Atraso</th>
      <th>Observação</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>SP</td>
      <td>8,18</td>
      <td>4,28%</td>
      <td>Excelente performance</td>
    </tr>
    <tr>
      <td>RJ</td>
      <td>14,68</td>
      <td>11,25%</td>
      <td>Região problemática</td>
    </tr>
    <tr>
      <td>RS</td>
      <td>14,51</td>
      <td>5,64%</td>
      <td>Lento, mas estável</td>
    </tr>
  </tbody>
</table>

<hr>

<h2>Correlação: Experiência vs Retenção</h2>
<p>O tempo médio de entrega (TME) e o valor do frete na primeira compra têm impacto direto na recompra.</p>

<table>
  <thead>
    <tr>
      <th>Experiência</th>
      <th>Taxa de Retorno</th>
      <th>Impacto</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>TME Médio + Frete Baixo</td>
      <td>3,96%</td>
      <td>✅ Melhor cenário</td>
    </tr>
    <tr>
      <td>TME Lento + Frete Alto</td>
      <td>2,86%</td>
      <td>❌ Pior cenário (-28%)</td>
    </tr>
  </tbody>
</table>

<hr>

<h2>Produtos com Zero Retenção</h2>
<table>
  <thead>
    <tr>
      <th>Categoria</th>
      <th>Taxa de Retenção</th>
      <th>Clientes Perdidos</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>cine_foto</td><td>0%</td><td>65</td></tr>
    <tr><td>construcao_ferramentas</td><td>0%</td><td>97</td></tr>
    <tr><td>fashion_underwear</td><td>0%</td><td>121</td></tr>
    <tr><td>artes</td><td>0%</td><td>202</td></tr>
  </tbody>
</table>

<hr>

<h2>Perfil dos Clientes Fiéis</h2>
<table>
  <thead>
    <tr>
      <th>Experiência</th>
      <th>Clientes</th>
      <th>GMV</th>
      <th>Insight</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>TME Médio + Frete Médio</td><td>88</td><td>R$ 817</td><td>Maior valor</td></tr>
    <tr><td>TME Rápido + Frete Baixo</td><td>64</td><td>R$ 717</td><td>Bom retorno</td></tr>
    <tr><td>Zero atrasos na 1ª compra</td><td colspan="3"><strong>Fator crítico de sucesso</strong></td></tr>
  </tbody>
</table>

<hr>

<h2>Recomendações Estratégicas</h2>

<h3>Ações Imediatas (0–3 meses)</h3>
<ul>
  <li>Revisar 6 categorias com alta taxa de perda.</li>
  <li>Implementar o “Padrão Ouro” para a primeira compra:
    <ul>
      <li>TME ≤ 14 dias</li>
      <li>Frete ≤ R$ 30</li>
      <li>Zero atrasos garantidos</li>
    </ul>
  </li>
  <li>Reduzir o TME no RJ de 21 para 14 dias.</li>
</ul>

<h3>Estratégias de Longo Prazo (3–12 meses)</h3>
<ul>
  <li>Programa de fidelidade pós-primeira-compra.</li>
  <li>Gestão ativa de categorias de risco.</li>
  <li>Padrões regionais de qualidade.</li>
  <li>Alertas automáticos para experiências negativas.</li>
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
    <tr><td>Taxa de Retenção</td><td>3,05%</td><td>4,00%</td><td>+31%</td></tr>
    <tr><td>Clientes Recorrentes</td><td>2.913</td><td>3.800</td><td>+887</td></tr>
    <tr><td>GMV de Clientes Fiéis</td><td>R$ 2,3M</td><td>R$ 3,0M</td><td>+R$ 700K</td></tr>
  </tbody>
</table>

<hr>

<h2>Próximos Passos e Responsabilidades</h2>
<table>
  <thead>
    <tr>
      <th>Área</th>
      <th>Responsável</th>
      <th>Prazo</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>Operações</td><td>Head de Operações</td><td>30 dias</td></tr>
    <tr><td>Marketing</td><td>Head de Marketing</td><td>60 dias</td></tr>
    <tr><td>Comercial</td><td>Head Comercial</td><td>45 dias</td></tr>
  </tbody>
</table>

<ul>
  <li><strong>Semana 1:</strong> Apresentação para stakeholders</li>
  <li><strong>Semanas 2–4:</strong> Implementação do Padrão Ouro</li>
  <li><strong>Semanas 3–6:</strong> Revisão das categorias críticas</li>
  <li><strong>A partir da Semana 7:</strong> Monitoramento contínuo</li>
</ul>

<hr>

<h2>Conclusão</h2>
<blockquote>“Garantir uma experiência consistente na primeira compra é a chave para transformar clientes únicos em fiéis.”</blockquote>

<p><strong>Base de dados analisada:</strong> 99.441 pedidos | 95.420 clientes únicos</p>
<p><strong>Período da análise:</strong> Novembro de 2025</p>

<hr>

<p><a href="https://github.com/JulioCesarSantosdv/Brazilian-E-Commerce-Public-Dataset" target="_blank" rel="noopener noreferrer">📎 Repositório do Projeto</a></p>

