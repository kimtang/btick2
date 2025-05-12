
# include <kdb/kdb.hpp>

namespace qtype = kx::qtype;

kx::K %name%_api_dot(kx::K a1, kx::K a2)
{
	return kx::dot(a1,a2);
}


# define kdb_dim 9

# define kdb_table																																			\
((boolean				,kx_KB,g,G,kx_kG,G*,	kdb_ktc_boolean,bool							,kdb_ctk_boolean		))									\
((short					,kx_KH,h,H,kx_kH,H*,	kdb_ktc_short,short								,kdb_ctk_short			))									\
((int					,kx_KI,i,I,kx_kI,I*,	kdb_ktc_int,int									,kdb_ctk_int			))									\
((long					,kx_KJ,j,J,kx_kJ,J*,	kdb_ktc_long,long long							,kdb_ctk_long			))									\
((real					,kx_KE,e,E,kx_kE,E*,	kdb_ktc_real,float								,kdb_ctk_real			))									\
((float					,kx_KF,f,F,kx_kF,F*,	kdb_ktc_float,double							,kdb_ctk_float			))									\
((symbol				,kx_KS,s,S,kx_kS,S*,	kdb_ktc_symbol,char*							,kdb_ctk_symbol			))									\
((timestampint64		,kx_KP,j,J,kx_kJ,J*,	kdb_ktc_timestampint64,boost::posix_time::ptime	,kdb_ctk_timestampint64	))									\
((date					,kx_KD,i,I,kx_kI,I*,	kdb_ktc_date,boost::gregorian::date				,kdb_ctk_date			))									\
((datetime				,kx_KZ,f,F,kx_kF,F*,	kdb_ktc_datetime,boost::posix_time::ptime		,kdb_ctk_datetime		))									\
((char					,kx_KC,g,G,kx_kC,G*,	kdb_ktc_char,char								,kdb_ctk_char			))									\

kx::K %name%_api_xn(kx::K x_){return kx::kj(x_->n);}
kx::K %name%_api_xt(kx::K x_){return kx::kc(x_->t);}
kx::K %name%_api_xp(kx::K x_){return kx::kj(reinterpret_cast<long>(x_));}


kx::K %name%_api_boolean_a(kx::K x_){return kx::kb(kx::value<qtype::boolean_>(x_));}
kx::K %name%_api_boolean_r(kx::K x_){return kx::raw_vector<qtype::boolean_>(x_).r1();} // to reuse the vector in raw_vector again you need to increase the count
kx::K %name%_api_boolean_v(kx::K x_){return kx::vector<qtype::boolean_>(x_);} // the vector is copied

kx::K %name%_api_list_r(kx::K x_) { return kx::raw_vector<qtype::list_>(x_).r1(); } // to reuse the vector in raw_vector again you need to increase the count
kx::K %name%_api_list_v(kx::K x_) { return kx::vector<qtype::list_>(x_); } // to reuse the vector in raw_vector again you need to increase the count

kx::K %name%_api_dict_k(kx::K x_) {
	std::int8_t t = static_cast<std::int8_t>(x_->t);
	if (t != 99) { return kx::krr("type"); }
	std::map<std::string, kx::K> m = kx::k2d(x_);
	kx::vector<qtype::symbol_> v(m.size());
	std::map<std::string, kx::K>::iterator m1 = m.begin();
	kx::vector<qtype::symbol_>::iterator v1 = v.begin();

	while (m1 != m.end())
	{
		*v1 = kx::ss((*m1).first.c_str() );
		++m1; ++v1;
	}

	return v;
}

kx::K %name%_api_dict_v(kx::K x_) {
	std::int8_t t = static_cast<std::int8_t>(x_->t);
	if (t != 99) { return kx::krr("type"); }
	std::map<std::string, kx::K> m = kx::k2d(x_);
	kx::raw_vector<qtype::list_> v(m.size());
	std::map<std::string, kx::K>::iterator m1 = m.begin();
	kx::raw_vector<qtype::list_>::iterator v1 = v.begin();

	while (m1 != m.end())
	{
		*v1 = (*m1).second;
		++m1; ++v1;
	}

	return v.r1();
}