/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   tools.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yridgway <yridgway@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/02/13 21:22:52 by yridgway          #+#    #+#             */
/*   Updated: 2023/04/05 04:04:29 by yridgway         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../includes/minirt.h"

char	*ft_strjoin_free(char	*s1, char *s2)
{
	char	*str;

	str = ft_strjoin(s1, s2);
	ft_free(s1);
	ft_free(s2);
	return (str);
}

char	*ft_chardup(char c)
{
	char	*tmp;

	tmp = (char *)ft_malloc(sizeof(char) * 2);
	tmp[0] = c;
	tmp[1] = '\0';
	return (tmp);
}

char	*ft_add_char(char *str, char c)
{
	char	*tmp;
	int		i;

	i = -1;
	if (!str)
		return (ft_chardup(c));
	tmp = (char *)ft_malloc(sizeof(char) * (ft_strlen(str) + 2));
	while (str && str[++i])
		tmp[i] = str[i];
	tmp[i] = c;
	tmp[i + 1] = '\0';
	return (ft_free(str), tmp);
}

char	*get_next_line(int fd)
{
	char	line[BUFFER_SIZE + 1];
	char	*copy;
	int		i;

	i = 0;
	while (i <= BUFFER_SIZE)
		line[i++] = '\0';
	i = 0;
	copy = line;
	while (read(fd, copy, 1) > 0)
	{
		if (*copy++ == '\n')
			break ;
		i++;
		if (i == BUFFER_SIZE)
			ft_error("Line too long", \
			"Please keep lines under 10000 characters", NULL);
	}
	if (copy > line)
	{
		if (line[i] == '\n')
			line[i] = '\0';
		return (ft_strdup(line));
	}
	return (NULL);
}
