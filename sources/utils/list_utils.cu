/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   list_utils.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yridgway <yridgway@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/02/18 19:13:35 by ionorb            #+#    #+#             */
/*   Updated: 2023/04/05 05:20:36 by yridgway         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../includes/minirt.h"

t_table	*ft_tablenew(char **line, int num_objs)
{
	t_table	*newy;
	int		i;

	i = 0;
	newy = (t_table *)ft_malloc(sizeof(t_table));
	newy->line = (char **)ft_malloc(sizeof(char *) * (num_objs + 1));
	while (line && line[i])
	{
		newy->line[i] = ft_strdup(line[i]);
		i++;
	}
	newy->line[i] = NULL;
	newy->next = NULL;
	ft_free_array(line);
	return (newy);
}

t_table	*ft_tableadd_back(t_table *table, t_table *newy)
{
	t_table	*tmp;

	if (!table)
		return (newy);
	tmp = table;
	while (tmp->next)
		tmp = tmp->next;
	tmp->next = newy;
	return (table);
}

t_table	*ft_tableadd_new(t_table *table, char **line, int num_objs)
{
	t_table	*newy;

	newy = ft_tablenew(line, num_objs);
	table = ft_tableadd_back(table, newy);
	return (table);
}
