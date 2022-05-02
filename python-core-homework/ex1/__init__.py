def build_roles_tree(mapping):
    result = {
        "categories": []
    }
    for id_in_sorted in mapping['categoryIdsSorted']:
        current_id = f'category-{id_in_sorted}'
        current_text = mapping['categories'][id_in_sorted]['name']
        current_items = [{
            'id': role_id,
            'text': mapping['roles'][role_id]['name']
        } for role_id in mapping['categories'][id_in_sorted]['roleIds']]

        result['categories'].append({
            'id': current_id,
            'text': current_text,
            'items': current_items
        })
    return result
