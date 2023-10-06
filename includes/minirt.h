/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   minirt.hpp                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yoel <yoel@student.42.fr>                  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/02/13 12:51:33 by gamoreno          #+#    #+#             */
/*   Updated: 2023/10/01 23:09:56 by yoel             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef MINIRT_H
# define MINIRT_H

extern "C"
{
	#include "mlx.h"
}
#include "libft.h"
# include "structs.h"
# include "define.h"
# include <stdlib.h>
# include <stdio.h>
# include <unistd.h>
# include <fcntl.h>
# include <math.h>
# include <time.h>
# include <sys/types.h>
# include <limits.h>
# include <errno.h>
# include <string.h>
# include <time.h>
# include <pthread.h>

//init
int			init_minirt(t_mrt *mrt, char **av, int ac);
__device__ __host__
int			ft_init_mlx(t_mrt *mrt);
__device__ __host__
void		ft_reinit(t_mrt *mrt);
__device__ __host__
int			valid_rt_file(char *file, int fd);
__device__ __host__
void		ft_set_mrt(t_mrt *mrt, char *file, int ix, int iy);
__device__ __host__
void		bump_to_array(t_bump *bump_map);
__device__ __host__
void		ft_set_mrt(t_mrt *mrt, char *file, int ix, int iy);
__device__ __host__
void		write_to_ppm(t_mrt *mrt);
__device__ __host__

//end
int			end_mrt(int i, void *mrt);
__device__ __host__

//parsing
int			ft_parse(t_mrt *mrt);
__device__ __host__
int			ft_strcmp_1(char *s1, char *s2);
__device__ __host__
int			eval_obj(char *line);
__device__ __host__
t_table		*ft_fill_table(int fd, int num_objs);
__device__ __host__
int			ft_arg_count(char **line);
__device__ __host__
void		ft_error(char *msg, char *extra, char *extra2);
__device__ __host__
t_option	ft_fill_options(t_mrt *mrt, t_table *table, t_rgb color);
__device__ __host__
int			eval_option(char *line);
__device__ __host__
int			*int_arrcpy(int *arr, int size);
__device__ __host__
void		ft_allocate_objs(t_mrt *mrt, int *count);
__device__ __host__

//eval objects
int			ft_strcmp_1(char *s1, char *s2);
__device__ __host__
int			eval_option(char *line);
__device__ __host__
int			eval_obj(char *line);
__device__ __host__

//cell filling
double		ft_fill_ratio(char *cell);
__device__ __host__
t_rgb		ft_fill_rgb(char *cell);
__device__ __host__
t_vec		ft_fill_pos(char *cell, int dir);
__device__ __host__
double		ft_fill_size(char *cell, int fov);
__device__ __host__
char		*ft_fill_xpm(char *cell);
__device__ __host__
void		ft_check_dots_and_minus(char *str);
__device__ __host__
int			check_valid_number(char *str);
__device__ __host__
void		valid_nums(char **line);
__device__ __host__
int			check_for_chars(char *str, char *cell);
__device__ __host__
int			out_of_range(double num, double min, double max);
__device__ __host__

//fill objects
t_cam		ft_fill_cam(t_table *table, char **line);
__device__ __host__
t_light		ft_fill_light(t_table *table, char **line, int amb);
__device__ __host__
t_sphere	ft_fill_sphere(t_mrt *mrt, t_table *table, char **line);
__device__ __host__
t_plane		ft_fill_plane(t_mrt *mrt, t_table *table, char **line);
__device__ __host__
t_cylinder	ft_fill_cylinder(t_mrt *mrt, t_table *table, char **line);
__device__ __host__
t_cone		ft_fill_cone(t_mrt *mrt, t_table *table, char **line);
__device__ __host__
t_triangle	ft_fill_triangle(t_mrt *mrt, t_table *table, char **line);
__device__ __host__
void		ft_fill_texture(t_mrt *mrt, char **line, t_option *option);
__device__ __host__

//utils
char		*get_next_line(int fd);
__device__ __host__
char		*ft_strjoin_free(char	*s1, char *s2);
__device__ __host__

//list
t_table		*ft_tablenew(char **line, int num_objs);
__device__ __host__
t_table		*ft_tableadd_back(t_table *table, t_table *newy);
__device__ __host__
t_table		*ft_tableadd_new(t_table *table, char **line, int num_objs);
__device__ __host__
int			mem_size(t_mem *mem);
__device__ __host__

//memory
void		*ft_malloc(long long int size);
__device__ __host__
void		*ft_memory(void *ptr, long long int size);
__device__ __host__
void		ft_free(void *ptr);
__device__ __host__
int			ft_free_one(t_mem *mem, void *thing);
__device__ __host__
void		ft_quit(int status);
// __device__ __host__
// void		clean_memory(void);
__device__ __host__
void		ft_add_to_mem(void *thing);
// __device__ __host__
// void		ft_close(int fd);
__device__ __host__
void		ft_close_fd(int *fd);
__device__ __host__
void		ft_save_mlx(void *ptr, void **mlx, void **win, void **img);
__device__ __host__
void		ft_free_mlx(void **mlx, void **win, void **img);
__device__ __host__
void		ft_get_mem_size(void);
__device__ __host__

//free
void		ft_free_array(char **array);
__device__ __host__
void		ft_free_table(t_table *table);
__device__ __host__

//math
double		int_pow(double basis, int exp);
__device__ __host__
double		vect_norm(t_vec v);
__device__ __host__
t_vec		fill_coord(double c1, double c2, double c3);
__device__ __host__
t_vec		normalize(t_vec v);
__device__ __host__
t_vec		scal_vec(double scalar, t_vec vector);
__device__ __host__
t_vec		vec_sum(t_vec v1, t_vec v2);
__device__ __host__
double		rad_and_deg(double angle, int ctrl);
__device__ __host__
void		print_vector(t_vec v);
__device__ __host__ //debug
double		min_v(double d1, double d2);
__device__ __host__
double		max_v(double d1, double d2);
__device__ __host__
double		v_abs(double x);
__device__ __host__
double		dot_prod(t_vec v1, t_vec v2);
__device__ __host__
t_vec		cross_prod(t_vec v1, t_vec v2);
__device__ __host__
double		vect_norm(t_vec v);
__device__ __host__
t_vec		vec_rest(t_vec v1, t_vec v2);
__device__ __host__
double		norm_raised_2(t_vec v);
__device__ __host__
t_base		get_obj_base(t_vec	dir);
__device__ __host__
t_vec		mtrx_by_vec(t_mtrx m, t_vec v);
__device__ __host__
double		mtrx_det(t_mtrx m);
__device__ __host__
t_mtrx		mtrx_trsp(t_mtrx m);
__device__ __host__
t_mtrx		mtrx_adj(t_mtrx m);
__device__ __host__
t_mtrx		scal_mtrx(double s, t_mtrx m);
__device__ __host__
t_mtrx		invert_mtrx(t_mtrx m);
__device__ __host__
double		perp_to_plane(t_vec point, t_vec plane_pos, t_vec plane_norm);
__device__ __host__
double		ft_max_valid(double a, double b);
__device__ __host__
t_mtrx		fill_mtrx(t_vec v1, t_vec v2, t_vec v3);
__device__ __host__
t_mtrx		init_base_mtrx(t_base *base);
__device__ __host__
double		solve_quad(t_discr *info);
__device__ __host__
double		decimal_part(double n);
__device__ __host__
t_mtrx		define_rot_mtrx(t_vec rot_axis, double sin, double cos);
__device__ __host__
t_base		general_rotation(t_base base, int ctrl, double rad);
__device__ __host__
double		integer_part(double n);
__device__ __host__
t_vec		get_spheric_coord(t_vec orig);
__device__ __host__
t_vec		get_cyl_coor(t_vec orig);
__device__ __host__
int			i_min_v(int a, int b);
__device__ __host__

//plane
t_vec		get_normal_plane(t_mrt *mrt, t_inter inter);
__device__ __host__
void		check_planes(t_mrt *mrt, t_inter *ctrl, t_vec point, t_vec dir);
__device__ __host__
double		distance_to_plane(t_vec start_point,
				t_vec plane_pos, t_vec plane_dir, t_vec ray);
__device__ __host__
t_rgb		get_plane_color(t_mrt *mrt, int index, t_vec intrsc);
__device__ __host__
t_vec		plane_bumped(t_mrt *mrt, t_inter inter, t_vec without);
__device__ __host__
t_rgb		get_plane_texture(t_mrt *mrt, t_inter inter);
__device__ __host__

//triangle
t_vec		get_normal_triangle(t_mrt *mrt, t_inter inter);
__device__ __host__
double		distance_to_triangle(t_vec start_point, t_triangle tri, t_vec ray);
__device__ __host__
void		check_triangles(t_mrt *mrt, t_inter *ctrl, t_vec point, t_vec dir);
__device__ __host__

//sphere
t_vec		get_normal_sphere(t_mrt *mrt, t_inter inter);
__device__ __host__
void		check_spheres(t_mrt *mrt, t_inter *ctrl, t_vec point, t_vec dir);
__device__ __host__
t_discr		get_sph_dscr(t_vec ncam, t_vec dir, double square_rad);
__device__ __host__
t_rgb		get_sphere_color(t_mrt *mrt, int index, t_vec intrsc);
__device__ __host__
t_vec		sphere_bumped(t_mrt *mrt, t_inter inter, t_vec without);
__device__ __host__

//cylinder
t_vec		get_normal_cylinder(t_mrt *mrt, t_inter inter);
__device__ __host__
void		check_cylinders(t_mrt *mrt, t_inter *ctrl, t_vec point, t_vec dir);
__device__ __host__
int			cam_in_cyl(t_mrt *mrt, int indx, t_vec new_cam);
__device__ __host__
t_rgb		print_cyl_color(t_mrt *mrt, int index);
__device__ __host__
t_cuad_ctr	get_dist_to_cyl(t_cylinder cyl, t_vec new_cam, t_vec new_dirc);
__device__ __host__
t_discr		get_cyl_disc(t_cylinder cyl, t_vec new_cam, t_vec new_dirc);
__device__ __host__
t_rgb		get_cyl_color(t_mrt *mrt, int index, t_vec intrsc, t_cuad_ctr ctr);
__device__ __host__
t_vec		cyl_normal_from_map(t_mrt *mrt, t_inter i, \
			t_vec c_cr, t_vec cyl_cr);
__device__ __host__
double		get_angular_resol(t_mrt *mrt, t_inter inter, double r_c, int width);
__device__ __host__
double		get_body_resol(t_mrt *mrt, t_inter inter, double r_c, int height);
__device__ __host__
t_rgb		get_cyl_texture(t_mrt *mrt, t_inter inter);
__device__ __host__

//cone
void		check_cones(t_mrt *mrt, t_inter *ctrl, t_vec point, t_vec dir);
__device__ __host__
int			cam_in_cone(t_mrt *mrt, int indx, t_vec n_c, double tan);
__device__ __host__
t_vec		get_normal_cone(t_mrt *mrt, t_inter inter);
__device__ __host__
void		move_cone(t_mrt *mrt, int key);
__device__ __host__
double		solve_cone_quad(t_discr *info, t_vec *f_n);
__device__ __host__
t_rgb		check_cone_contour(t_mrt *mrt, t_vec curr_dir, t_rgb color);
__device__ __host__
t_cuad_ctr	get_dist_to_cone(t_cone cone, t_vec n_c, t_vec n_d, double tang);
__device__ __host__
int			contour_cone(t_mrt *mrt, t_vec *newy, double c, double tang);
__device__ __host__
t_discr		get_cone_disc(t_vec *f_n, double tan);
__device__ __host__
void		fov_ctr(t_mrt *mrt, int key);
__device__ __host__
t_rgb		get_cone_color(t_mrt *mrt, int i, t_vec *newy, t_cuad_ctr ctr);
__device__ __host__
t_vec		cone_nml_frm_map(t_mrt *mrt, t_inter itr, t_vec c_cr, t_vec cyl_cr);
__device__ __host__
t_vec		cone_bumped(t_mrt *mrt, t_inter inter, t_vec without);
__device__ __host__
t_rgb		get_cone_texture(t_mrt *mrt, t_inter inter);
__device__ __host__

//camera
t_inter		check_intersections(t_mrt *mrt, t_vec point, t_vec dir);
__device__ __host__
void		set_all_cam_values(t_cam *cam, int ix);
__device__ __host__
t_vec		screen_pxl_by_indx(t_mrt *mrt, t_cam *cam, int i, int j);
__device__ __host__
void		my_mlx_pixel_put(t_mrt *mrt, int x, int y, int color);
__device__ __host__
void		pixel_calcul(t_mrt *mrt);
__device__ __host__
int			get_pixel_color(t_mrt *mrt, int x, int y);
__device__ __host__
double		distance_to_cap(t_vec start_pos, t_cylinder cylinder, t_vec ray);
__device__ __host__
t_inter		fill_ctrl(t_mrt *mrt, int type, int index, double dist);
__device__ __host__
t_rgb		chosen_obj(t_mrt *mrt, int x, int y, t_rgb color);
__device__ __host__
t_vec		get_normal_at_point(t_mrt *mrt, t_inter inter);
__device__ __host__
t_mrt		*ft_copy_mrt(t_mrt *mrt);
__device__ __host__
void		ft_percentage_bar(t_mrt *mrt);
__device__ __host__
void		ft_free_mrt(t_mrt *mrt, int num);
__device__ __host__

//color
// t_rgb		get_color(t_mrt *mrt, t_inter *ctr, t_vec dir);
__device__ __host__
t_rgb		ft_make_rgb(int r, int g, int b);
__device__ __host__
t_rgb		ft_make_rgb_ratio(t_rgb color);
__device__ __host__
t_rgb		normalize_color(t_rgb color);
__device__ __host__
t_rgb		show_light_sources(t_mrt *mrt, t_rgb color, t_vec dir);
__device__ __host__
t_rgb		get_opposite_color(t_rgb color);
__device__ __host__
// double		get_angle_between(t_vec v1, t_vec v2);
__device__ __host__
t_rgb		get_ambient(t_rgb ctr, t_light amb, double mirror);
__device__ __host__
t_rgb		get_reflection(t_mrt *mrt, t_inter *ctr, t_vec dir);
__device__ __host__
t_rgb		get_diffuse(t_inter *ctr, t_vec to_light, \
t_light light);
__device__ __host__
t_rgb		get_specular(t_inter *ctr, t_vec pos, t_vec to_light, \
t_light light);
__device__ __host__
t_rgb		mult_color(t_rgb color, double mult);
__device__ __host__
t_rgb		add_color(t_rgb color1, t_rgb color2);
__device__ __host__
t_inter		check_shaddow(t_mrt *mrt, t_inter *ctr, t_vec dir, double len);
__device__ __host__
t_rgb		get_radiance(t_mrt *mrt, t_inter *ctr, t_light light);
__device__ __host__
t_rgb		apply_lighting(t_mrt *mrt, t_inter *ctr, t_vec dir, t_rgb color);
__device__ __host__
int			diminish_color(int color, double percent);
__device__ __host__
t_rgb		convert_to_rgb(int color);
__device__ __host__

//hooks_management
int			key_press(int key, void *mrt);
__device__ __host__
int			mouse_press(int button, int x, int y, void *mrt);
__device__ __host__
void		move_obj(t_mrt *mrt, int key);
__device__ __host__
void		rotate_obj(t_mrt *mrt, int key);
__host__
void		render_scene(t_mrt *mrt);
__device__ __host__
void		chg_options(t_mrt *mrt, int key);
__device__ __host__
void		radius_ctr(t_mrt *mrt, int key);
__device__ __host__
void		height_ctr(t_mrt *mrt, int key);
__device__ __host__
void		bump_option(t_mrt *mrt, int key);
__device__ __host__
void		chess_ctr(t_mrt *mrt, int key);
__device__ __host__
void		cam_ctr(t_mrt *mrt, int key);
__device__ __host__
t_curr_ob	define_curr_obj(int type, int index);
__device__ __host__
void		texture_option(t_mrt *mrt, int key);
__device__ __host__

//info display
void		display_strings(t_mrt *mrt);
__device__ __host__
t_rgb		ft_get_obj_color(t_mrt *mrt, int type, int index);
__device__ __host__
char		*ft_get_color_str(t_rgb color);
__device__ __host__

//save
void		save_scene(t_mrt *mrt);
__device__ __host__
void		write_to_ppm(t_mrt *mrt);
__device__ __host__
void		ft_write_planes(t_plane *plane, int count, int fd);
__device__ __host__
void		ft_write_spheres(t_sphere *sphere, int count, int fd);
__device__ __host__
void		ft_write_cylinders(t_cylinder *cylinder, int count, int fd);
__device__ __host__
void		ft_write_triangles(t_triangle *triangle, int count, int fd);
__device__ __host__
void		ft_write_to_file(char *line, int fd);
__device__ __host__
char		*ft_write_pos(t_vec pos);
__device__ __host__
t_vec		ft_unnormalize(t_vec vec);
__device__ __host__
char		*ft_write_dir(t_vec dir);
__device__ __host__
char		*ft_write_rgb(t_rgb color);
__device__ __host__

//bump map
t_vec		bump_nrml_by_coor(t_option *opt, int x, int y, double height);
__device__ __host__
t_vec		get_bump_nrml(t_vec new_n, t_base tang_base, t_mtrx chg);
__device__ __host__

#endif