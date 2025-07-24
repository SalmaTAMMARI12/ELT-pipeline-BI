{ % macro generate_pivot_form(form_id) % } { % -
set captions_query - % }
select distinct caption
from { { ref('src_field') } }
where form_id = { { form_id } }
order by caption { % - endset - % } { % -
set captions_results = run_query(captions_query) - % } { % - if captions_results is none - % } { { exceptions.raise_compiler_error(
        "Erreur lors de la récupération des captions pour form_id=" ~ form_id
    ) } } { % - endif - % } { % -
set captions = captions_results.columns [0].values() - % }
select d.application_id,
    { % - for caption in captions % } max(
        case
            when f.caption = '{{ caption }}' then d.value
        end
    ) as "{{ caption }}" { % if not loop.last % },
    { % endif % } { % - endfor % }
from { { ref('stg_data') } } d
    join { { ref('src_field') } } f on d.field_id = f.id
where d.form_id = { { form_id } }
group by d.application_id
order by d.application_id { % endmacro % }