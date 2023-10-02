/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   parsing_utils.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yridgway <yridgway@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/02/18 21:02:11 by ionorb            #+#    #+#             */
/*   Updated: 2023/04/05 05:24:07 by yridgway         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../includes/minirt.h"

void	ft_allocate_objs(t_mrt *mrt, int *count)
{
	if (count[LIGHT])
		mrt->light = (t_light*)ft_malloc(sizeof(t_light) * count[LIGHT]);
	if (count[SPHERE])
		mrt->sphere = (t_sphere*)ft_malloc(sizeof(t_sphere) * count[SPHERE]);
	if (count[PLANE])
		mrt->plane = (t_plane*)ft_malloc(sizeof(t_plane) * count[PLANE]);
	if (count[CYLINDER])
		mrt->cylinder = (t_cylinder*)ft_malloc(sizeof(t_cylinder) * count[CYLINDER]);
	if (count[CONE])
		mrt->cone = (t_cone*)ft_malloc(sizeof(t_cone) * count[CONE]);
	if (count[TRIANGLE])
		mrt->triangle = (t_triangle*)ft_malloc(sizeof(t_triangle) * count[TRIANGLE]);
}

int	ft_arg_count(char **line)
{
	int	i;

	i = 0;
	while (line[i])
		i++;
	return (i);
}

t_table	*ft_fill_table(int fd, int num_objs)
{
	char	*line;
	t_table	*table;

	table = NULL;
	line = ("#");
	while (line)
	{
		if (line && line[0] && line[0] != '\n' && line[0] != '#')
			table = ft_tableadd_new(table, ft_split_ws(line), num_objs);
		ft_free(line);
		line = get_next_line(fd);
	}
	return (table);
}

int	*int_arrcpy(int *arr, int size)
{
	int	*newy;
	int	i;

	i = 0;
	newy = (int *)ft_malloc(sizeof(int) * size);
	while (i < size)
	{
		newy[i] = arr[i];
		i++;
	}
	return (newy);
}

void	ft_error(char *msg, char *extra, char *extra2)
{
	printf("Error\n");
	if (msg && extra && extra2)
		printf("%s: %s: %s\n", msg, extra, extra2);
	else if (msg && extra)
		printf("%s: %s\n", msg, extra);
	else if (msg)
		printf("%s\n", msg);
	ft_quit(EXIT_ERROR);
}
