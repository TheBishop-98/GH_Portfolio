{% macro generate_doc_blocks(source_name, table, prefix)  %}

{%- set source_relation = source(source_name, table) -%}

{%- set columns = adapter.get_columns_in_relation(source_relation)-%}

{% set doc_block = [] %}

{%- for column in columns%}
{% do doc_block.append('{% docs '~ prefix ~ '_'~column.name ~ ' %}')%}
{% do doc_block.append(' column description ')%}
{% do doc_block.append('{% enddocs %}')%}
{% do doc_block.append('')%}
{% endfor %}

{% if execute %}
{% set final = doc_block | join('\n')%}
{{log(final, info= True)}}
{% do return(final)%}
{% endif %}
{% endmacro %}